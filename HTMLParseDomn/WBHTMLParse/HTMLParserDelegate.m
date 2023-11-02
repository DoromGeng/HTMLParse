//
//  HTMLParserDelegate.m
//  123456
//
//  Created by 58 on 2023/10/27.
//

#import "HTMLParserDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <NSAttributedString+YYText.h>
#import "UIColor+Hex.h"

@implementation HTMLParserDelegate

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [UIColor wb_colorWithHexString:color];
}

+ (NSAttributedString *)attachmenSize:(CGSize)size url:(NSURL *)url font:(UIFont *)font {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView sd_setImageWithURL:url];
    
    return [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleToFill attachmentSize:size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
}

@end
