//
//  HTMLParser.h
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import <UIKit/UIKit.h>
#import "HTMLTagHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HTMLParserProtocol <NSObject>

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (NSAttributedString *)attachmenSize:(CGSize)size url:(NSURL *)url font:(UIFont *)font;

@end

@interface HTMLParser : NSObject

@property(nonatomic, strong, class)Class<HTMLParserProtocol>delagate;

/// - Parameter string: eg:<font color='ff552e'>文本</font>
+ (NSAttributedString *)parserString:(NSString *)string;

/// - Parameters:
///   - string:eg:<font size='20'>文本</font>
///   - attributes: @{KHTMLFONTSIZE:@"20", KHTMLFONTCOLOR:@"#ff552e"}
///
+ (NSAttributedString *)parserString:(NSString *)string attributes:(nullable NSDictionary *)attributes;

@end


NS_ASSUME_NONNULL_END
