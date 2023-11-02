//
//  HTMLParser.m
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import "HTMLParser.h"
#import "HTMLParserTagRegex.h"
#import "HTMLBaseTag+Tool.h"
#import <objc/runtime.h>

static NSString *const string = @"<img src='https://wos.58cdn.com.cn/cDazYxWcDHJ/picasso/c8m6fpum__w204_h80.png' width='50' height='20'></img>111111<font color='#ff432e' name='PingFangSC-Regular'>测试文本:App启动完成初始化,减少首次使用耗时</font>";;

@implementation HTMLParser

+ (Class<HTMLParserProtocol>)delagate {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setDelagate:(Class<HTMLParserProtocol>)delagate {
    objc_setAssociatedObject(self, @selector(delagate), delagate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self parserString:string];
    });
}

+ (NSAttributedString *)parserString:(NSString *)string {
    return [self parserString:string attributes:nil];
}

+ (NSAttributedString *)parserString:(NSString *)string attributes:(nullable NSDictionary *)attributes {
    
    NSMutableArray<HTMLBaseTag *> *nodeStack = [NSMutableArray array];
    
    HTMLBaseTag *root = [[HTMLBaseTag alloc] init];
    root.attributes = attributes;
    
    __block HTMLBaseTag *currentTag = root;
    [HTMLParserTagRegex enumerateMatchesInString:string block:^(HTMLBaseTag * _Nonnull htmlTag) {
        if (htmlTag.tagType == HTMLTagType_startTag) {
            [currentTag appendChild:htmlTag];
            currentTag = htmlTag;
            [nodeStack addObject:htmlTag];
        } else if (htmlTag.tagType == HTMLTagType_closeTag) {
            HTMLBaseTag *last = [nodeStack lastObject];
            [nodeStack removeObject:last];
            if([htmlTag.tagName isEqualToString:last.tagName]) {
                currentTag = currentTag.parent ? currentTag.parent : currentTag;
            }
        } else if (htmlTag.tagType == HTMLTagType_selfCloseTag) {
            [currentTag appendChild:htmlTag];
        } else if (htmlTag.tagType == HTMLTagType_string) {
            [currentTag appendChild:htmlTag];
        }
    }];
    
    NSMutableAttributedString *muAtt = [root bulidAtt];
    NSString *lineSpace = attributes[KHTMTAGPARAGRAPHSTYLELINESPACE];
    if(lineSpace.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpace.floatValue;
        [muAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, muAtt.length)];
    }
    return muAtt;
}

@end
