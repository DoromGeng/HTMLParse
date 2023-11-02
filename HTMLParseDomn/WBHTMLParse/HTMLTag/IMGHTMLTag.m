//
//  IMGHTMLTag.m
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import "IMGHTMLTag.h"
#import "HTMLTagFactory.h"
#import "HTMLBaseTag+Tool.h"
#import "HTMLParser.h"

@implementation IMGHTMLTag

- (NSAttributedString *)attributedString {
    
    NSString *src = self.attributes[KHTMLIMGSRC];
    NSString *widthStr = self.attributes[KHTMLIMGWIDTH];
    NSString *heightStr = self.attributes[KHTMLIMGHEIGHT];
    NSAttributedString *attachText = [[NSAttributedString alloc] init];
    if(src.length > 0) {
        attachText = [HTMLParser.delagate attachmenSize:CGSizeMake(widthStr.floatValue, heightStr.floatValue) url:[NSURL URLWithString:src] font:[self parseFont]];
    }
    return attachText;
}

@end
