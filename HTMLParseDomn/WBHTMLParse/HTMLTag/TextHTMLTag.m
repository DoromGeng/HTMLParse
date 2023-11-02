//
//  TextHTMLTag.m
//  123456
//
//  Created by 58 on 2023/10/25.
//

#import "TextHTMLTag.h"
#import "HTMLTagFactory.h"
#import "HTMLParser.h"
#import "HTMLBaseTag+Tool.h"

@implementation TextHTMLTag

- (NSAttributedString *)attributedString {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [self parseColor];
    attributes[NSFontAttributeName] = [self parseFont];
    
    return [[NSAttributedString alloc] initWithString:self.string attributes:attributes];
}

@end
