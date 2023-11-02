//  Created by Jason Morrissey

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *  色值转换成UIColor
 *  @param hexColor:16进制色值
 *  @return UIColor类型
 */
+ (UIColor *)colorWithHex:(long)hexColor;
/**
 *  色值转换成UIColor
 *  @param hexColor:16进制色值
 *  @param opacity:颜色的透明度0~1
 *  @return UIColor类型
 */
+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)opacity;
/**
 *  根据质量级别获取UIColor颜色
 *  @param qulityLevel 质量级别
 *  @return UIColor类型
 */
+ (UIColor *)getColorWithQulityLevel:(int)qulityLevel;
/**
 *  UIColor转换成UIImage
 *  @param color UIColor颜色
 *  @param size  image的大小
 *  @return UIImage类型
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
/**
 *  色值字符串转换成UIColor
 *  @param color 16进制字符串
 *  @return UIColor类型
 */

+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) wb_colorWithHexString: (NSString *)color;

+ (UIColor *) wb_colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

/**
 通过ARGB字符串获取UIColor

 @param hexColorString ARGB字符串
 @return UIColor
 */
+ (UIColor *)argbColorWithHextColorString:(NSString *)hexColorString;


/*
 * 转换为#000000格式
 */
- (NSString*)convertHexString;

/**
 渐变方式
 
 - WBImageGradientChangeDirectionLevel:              水平渐变
 - WBImageGradientChangeDirectionVertical:           竖直渐变
 - WBImageGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - WBImageGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, WBImageGradientChangeDirection) {
    WBImageGradientChangeDirectionLevel,
    WBImageGradientChangeDirectionVertical,
    WBImageGradientChangeDirectionUpwardDiagonalLine,
    WBImageGradientChangeDirectionDownDiagonalLine,
};

/**
 创建渐变颜色
 
 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色
 
 @return 创建的渐变颜色
 */
+ (instancetype)wb_colorGradientChangeWithSize:(CGSize)size
                                     direction:(WBImageGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;

#pragma mark - iOS 13 暗黑模式适配相关接口
/**
 
 
 @param hexLightColor 浅色模式 16 进制色值，alpha 值默认 1.0
 @param hexDarkColor 深色模式 16进制色值，alpha 值默认 1.0
 @return 返回 UIColor，iOS 13及以上系统根据系统显示模式动态返回颜色，iOS 13以下系统，返回浅色模式颜色
 */
+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor darkColorWithHex:(long)hexDarkColor;


/// 色值转换成UIColor，iOS 13 及以上系统，根据系统显示模式动态返回
/// @param hexLightColor 浅色模式 16 进制色值
/// @param ligthAlpha 浅色颜色 alpha
/// @param hexDarkColor 深色模式 16进制色值
/// @param darkAlpha 深色颜色 alpha
+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor lightColorAlpha:(CGFloat)ligthAlpha darkColorWithHex:(long)hexDarkColor darkColorAlpha:(CGFloat)darkAlpha;

/// 色值转换成UIColor，iOS 13 及以上系统，根据系统显示模式动态返回
/// @param hexLightColor 浅色模式 16 进制色值，alpha 值默认 1.0
/// @param hexDarkColor 深色模式 16进制色值
/// @param darkAlpha 深色颜色 alpha 值
+ (UIColor *)wb_lightColorWithHex:(long)hexLightColor darkColorWithHex:(long)hexDarkColor darkColorAlpha:(CGFloat)darkAlpha;


/// 色值字符串转 UIColor，iOS 13及以上系统根据当前系统显示模式动态返回颜色，iOS 13以下系统，返回浅色模式颜色。十六进制字符串颜色支持 #RRGGBB、#AARRGGBB 格式（#号可以忽略）
/// @param lightColor 浅色模式颜色
/// @param darkColor 深色模式颜色
+ (UIColor *) wb_lightColorWithHexString: (NSString *)lightColor darkColorWithHexString:(NSString *)darkColor;

/// iOS 13及以上系统根据当前系统显示模式动态返回颜色，iOS 13以下系统，返回浅色模式颜色。
/// @param lightColor 浅色模式颜色
/// @param darkColor 深色模式颜色
+ (UIColor *)wb_dynamicColorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end
