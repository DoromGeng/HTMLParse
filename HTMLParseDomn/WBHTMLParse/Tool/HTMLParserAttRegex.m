//
//  HTMLParserAttributesRegular.m
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import "HTMLParserAttRegex.h"

static NSString *const regexAttributes = @"\\s*(?<name>\\w+)\\s*=\\s*(?:['\"]?(?<value>[^'\"\\s>]+)['\"]?)\\s*";

static NSRegularExpression const* attributesRegular;

@implementation HTMLParserAttRegex

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        attributesRegular = [[NSRegularExpression alloc] initWithPattern:regexAttributes options:NSRegularExpressionCaseInsensitive error:&error];
        if(error) {
            NSAssert(NO, @"初始化失败");
        }
    });
}

+ (NSDictionary *)enumerateAttributesInString:(NSString *)string {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributesRegular enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable textResult, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSString *name = [string substringWithRange:[textResult rangeWithName:@"name"]];
        if(name.length > 0) {
            NSString *value = [string substringWithRange:[textResult rangeWithName:@"value"]];
            attributes[name] = value;
        }
    }];
    return attributes;
}

@end
