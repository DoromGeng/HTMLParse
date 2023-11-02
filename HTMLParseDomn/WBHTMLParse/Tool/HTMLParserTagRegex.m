//
//  ParserRegexr.m
//  123456
//
//  Created by 58 on 2023/10/24.
//

#import "HTMLParserTagRegex.h"
#import "NSTextCheckingResult+Tool.h"
#import "HTMLTagFactory.h"
#import "HTMLParserAttRegex.h"

static NSString *const regexPattern = @"<(?:(?<closeTag>/)?(?<tagName>[A-Za-z0-9]+)(?<tagAttributes>(?:\\s*(\\w+)\\s*=(?:(.*?)))*)\\s*(?<selfClosingTag>/)?>)";

static NSRegularExpression const* tagRegular;

@implementation HTMLParserTagRegex

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        tagRegular = [[NSRegularExpression alloc] initWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
        if(error) {
            NSAssert(NO, @"初始化失败");
        }
    });
}

+ (void)enumerateMatchesInString:(NSString *)string block:(ParserRegexrBlock)block {
    
    __block NSTextCheckingResult *last = nil;
    [tagRegular enumerateMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable current, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        @autoreleasepool {
            if(current) {
                NSString *tagName = [current subString:string name:@"tagName"];
                BOOL closeTag = [[current subString:string name:@"closeTag"] containsString:@"/"];
                BOOL selfClosingTag = [[current subString:string name:@"selfClosingTag"] containsString:@"/"];
                BOOL isbetWeen = [self checkBetweenLastCheckingResult:last current:current];
                if(isbetWeen) {
                    NSString *betWeen = [string substringWithRange:NSMakeRange(last.range.location + last.range.length,current.range.location - (last.range.location + last.range.length))];
                    HTMLBaseTag *tag = [[KHTMLTAGFACTORY[KHTMLTEXT] alloc] init];
                    tag.tagType = HTMLTagType_string;
                    tag.string = betWeen;
                    if(block) {
                        block(tag);
                    }
                }
                
                NSString *sub = [string substringWithRange:current.range];
                HTMLBaseTag *tag = [[KHTMLTAGFACTORY[tagName] alloc] init];
                tag.tagName = tagName;
                HTMLTagType tagType = HTMLTagType_startTag;
                if(closeTag) {
                    tagType = HTMLTagType_closeTag;
                }
                
                if(selfClosingTag || [self checkIsSelfCloseTag:tagName]) {
                    tagType = HTMLTagType_selfCloseTag;
                }
                tag.tagType = tagType;
                if(tagType == HTMLTagType_startTag) {
                    tag.attributes = [HTMLParserAttRegex enumerateAttributesInString:sub];;
                }
                if(block) {
                    block(tag);
                }
                last = current;
            }
        }
    }];
    NSString *resetString = [self resetStringLastCheckingResult:last string:string];
    if(resetString) {
        HTMLBaseTag *tag = [[KHTMLTAGFACTORY[KHTMLTEXT] alloc] init];
        tag.tagType = HTMLTagType_string;
        tag.string = resetString;
        if(block) {
            block(tag);
        }
    }
}

+ (BOOL)checkBetweenLastCheckingResult:(NSTextCheckingResult *)last current:(NSTextCheckingResult *)current {
    BOOL isBetween = NO;
    if(!last) {
        isBetween = current.range.location > 0;
    } else {
        isBetween =  current.range.location > (last.range.location + last.range.length);
    }
    return isBetween;
}

+ (NSString *)resetStringLastCheckingResult:(NSTextCheckingResult *)last string:(NSString *)string {
    if(!last) {
        return string;
    } else {
        NSUInteger lastUp = last.range.location + last.range.length;
        NSUInteger total = string.length;
        NSUInteger dvalue = total - lastUp;
        if(dvalue > 0) {
            return [string substringWithRange:NSMakeRange(lastUp, dvalue)];
        }
    }
    return nil;
}

+ (BOOL)checkIsSelfCloseTag:(NSString *)tagName {
    return [tagName isEqualToString:KHTMLNEWLINE];
}

@end
