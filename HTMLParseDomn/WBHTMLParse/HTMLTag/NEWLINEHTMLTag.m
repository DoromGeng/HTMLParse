//
//  NEWLineHTMLTag.m
//  YellowPage
//
//  Created by 58 on 2023/10/31.
//

#import "NEWLINEHTMLTag.h"
#import "HTMLTagFactory.h"

@implementation NEWLINEHTMLTag

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:@"\n"];
}

@end
