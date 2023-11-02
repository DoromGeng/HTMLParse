//
//  HTMLBaseTag+Tool.m
//  123456
//
//  Created by 58 on 2023/10/27.
//

#import "HTMLBaseTag+Tool.h"
#import "HTMLTagFactory.h"
#import "HTMLParser.h"

typedef void(^HTMLBaseTagBlock)(HTMLBaseTag *item);

@implementation HTMLBaseTag (Tool)

- (UIColor *)parseColor {
    
    UIColor *color = KDEFAULTFONTCONFIG[KHTMLFONTCOLOR];
    NSString *colorStr = self.attributes[KHTMLFONTCOLOR];
    //策略:1.识别red等字符串 2.16进制转颜色
    if(colorStr.length > 0) {
        UIColor *tempColor = [self colorWithString:colorStr];
        if(!tempColor) {
            tempColor = [HTMLParser.delagate colorWithHexString:colorStr];
        }
        if(tempColor) {
            color = tempColor;
        }
    }
    return color;
}

- (UIColor *)colorWithString:(NSString *)string {
    
    if([string isEqualToString:@"red"]) {
        return [UIColor redColor];
    }
    return nil;
}

- (UIFont *)parseFont {
    NSString *fontName = self.attributes[KHTMLFONTNAME];
    NSString *size = self.attributes[KHTMLFONTSIZE];
    if(size.length == 0) {
        size = KDEFAULTFONTCONFIG[KHTMLFONTSIZE];
    }
    UIFont *font = [UIFont systemFontOfSize:size.floatValue];
    if(fontName.length > 0) {
        UIFont *temp = [UIFont fontWithName:fontName size:size.floatValue];
        if(temp) {
            font = temp;
        }
    }
    return font;
}

- (NSMutableAttributedString *)bulidAtt {
    NSMutableAttributedString * all = [[NSMutableAttributedString alloc] init];
    [self bulidAttWithBlock:^(HTMLBaseTag *item) {
        [all appendAttributedString:item.attributedString];
    }];
    return all;
}

- (void)bulidAttWithBlock:(HTMLBaseTagBlock)block   {
    if(self.childs.count == 0) {
        if(block) {
            block(self);
        }
    }
    for (HTMLBaseTag *tag in self.childs) {
        [tag bulidAttWithBlock:block];
    }
}

@end
