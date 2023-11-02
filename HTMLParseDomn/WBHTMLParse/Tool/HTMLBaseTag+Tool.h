//
//  HTMLBaseTag+Tool.h
//  123456
//
//  Created by 58 on 2023/10/27.
//

#import "HTMLBaseTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMLBaseTag (Tool)

- (UIColor *)parseColor;
- (UIFont *)parseFont;
- (NSMutableAttributedString *)bulidAtt;

@end

NS_ASSUME_NONNULL_END
