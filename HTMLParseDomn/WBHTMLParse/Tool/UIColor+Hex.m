//  Created by Jason Morrissey

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)opacity
{
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];  
}

+ (UIColor *)getColorWithQulityLevel:(int)qulityLevel
{
    UIColor *color = [UIColor colorWithHex:0x42badc];
    if(qulityLevel<=50){
        color = [UIColor colorWithHex:0x29a532];
    }else if (qulityLevel > 50 &&  qulityLevel <= 100){
        color = [UIColor colorWithHex:0xc5e801];
    }else if (qulityLevel > 100 && qulityLevel <= 150){
        color = [UIColor colorWithHex:0xf49a0b];
    }else if (qulityLevel > 150 && qulityLevel <= 200){
        color = [UIColor colorWithHex:0xfb1c1c];
    }else if (qulityLevel > 200 && qulityLevel <= 300){
        color = [UIColor colorWithHex:0xaf00bf];
    }else if (qulityLevel > 300){
       color = [UIColor colorWithHex:0x6000b1];
    }
    return color;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    return [self wb_colorWithHexString:color];
}

+ (UIColor *) wb_colorWithHexString: (NSString *)color
{
    return [[self class] wb_colorWithHexString:color alpha:1];
}
+ (UIColor *) wb_colorWithHexString: (NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] < 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
//    //alpha
//    NSString *aString = @"ff";
//    if (cString.length >= 8) {
//        range.location = 6;
//        aString = [cString substringWithRange:range];
//    }
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}


+ (UIColor *) wb_colorWithAlphaHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] < 6)
        return [UIColor clearColor];
    
    if (cString.length == 6) {
        return [self wb_colorWithHexString:cString alpha: 1.0];
    } else if (cString.length == 8){
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *aString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 6;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int a, r, g, b;
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:((float) a / 255.0f)];
    } else {
        return [UIColor clearColor];
    }
}


#pragma mark - ARGB
//支持ARGB
+ (UIColor *)argbColorWithHextColorString:(NSString *)hexColorString {
    //这里是alpha传1，在colorWithHextColorString alpha 里面做了alpha修改
    return [self argbColorWithHextColorString:hexColorString alpha:1.0f];
}

//支持rgb,argb
+ (UIColor *)argbColorWithHextColorString:(NSString *)hexColorString alpha:(CGFloat)alphaValue {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    //排除掉  @\"
    if ([hexColorString hasPrefix:@"@\""]) {
        hexColorString = [hexColorString substringWithRange:NSMakeRange(2, hexColorString.length-3)];
    }
    
    //排除掉 #
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
    
    if (nil != hexColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:hexColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    if ([hexColorString length]==8) {   //如果是8位，就那其中的alpha
        alphaValue = (float)(unsigned char)(colorCode>>24)/0xff;
    }
    
//    NSLog(@"alpha:%f----r:%f----g:%f----b:%f",alphaValue,(float)redByte/0xff,(float)greenByte/0xff,(float)blueByte/0xff);
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alphaValue];
    return result;
    
}


- (NSString*)convertHexString{
    NSInteger cpts = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];//红色
    CGFloat g = components[1];//绿色
    CGFloat b = components[2];//蓝色
    if (cpts == 4) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
    }
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
    
}

+ (instancetype)wb_colorGradientChangeWithSize:(CGSize)size
                                     direction:(WBImageGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == WBImageGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case WBImageGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case WBImageGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case WBImageGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case WBImageGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

#pragma mark - iOS 13 暗黑模式适配相关接口

/*
 * 58 App 中增加了深色模式控制开关，关闭开关时 keyWindow.overrideUserInterfaceStyle 重置为 UIUserInterfaceStyleLight。 [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleLight，表明 App 关闭了暗黑模式，系统可能处于暗黑模式状态。
 * 为了解决部分场景（首页滚动时搜索框边框显示问题，部落贴富文本显示问题）显示异常问题，暗黑模式判断增加了 keyWindow overrideUserInterfaceStyle 逻辑，代码如下
 * if (trait.userInterfaceStyle == UIUserInterfaceStyleDark && [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {...}
 * 获取当前 App 状态不能使用该属性，参考苹果文档（Reading this property does not return the current `UIUserInterfaceStyle`. Use `traitCollection.userInterfaceStyle` instead.）
 */

+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor darkColorWithHex:(long)hexDarkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark && [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {
                return [self colorWithHex:hexDarkColor alpha: 1.0];
            } else {
                return [self colorWithHex:hexLightColor alpha:1.0];
            }
        }];
    } else {
        return [self colorWithHex:hexLightColor alpha:1.0];
    }
}

+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor lightColorAlpha:(CGFloat)ligthAlpha darkColorWithHex:(long)hexDarkColor darkColorAlpha:(CGFloat)darkAlpha{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark && [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {
                return [self colorWithHex:hexDarkColor alpha:darkAlpha];
            } else {
                return [self colorWithHex:hexLightColor alpha:ligthAlpha];
            }
        }];
    } else {
        return [self colorWithHex:hexLightColor alpha:ligthAlpha];
    }
}

+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor darkColorWithHex:(long)hexDarkColor darkColorAlpha:(CGFloat)darkAlpha{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark && [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {
                return [self colorWithHex:hexDarkColor alpha:darkAlpha];
            } else {
                return [self colorWithHex:hexLightColor alpha:1.0];
            }
        }];
    } else {
        return [self colorWithHex:hexLightColor alpha:1.0];
    }
}

+ (UIColor *)wb_lightColorWithHexString: (NSString *)lightColor darkColorWithHexString:(NSString *)darkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark &&  [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {
                return [self wb_colorWithAlphaHexString: darkColor];
            } else {
                return [self wb_colorWithAlphaHexString: lightColor];
            }
        }];
    } else {
        return [self wb_colorWithAlphaHexString: lightColor];
    }
}

+ (UIColor *)wb_dynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark && [UIApplication sharedApplication].keyWindow.overrideUserInterfaceStyle != UIUserInterfaceStyleLight) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

@end
