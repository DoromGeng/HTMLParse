//
//  ParserRegexr.h
//  123456
//
//  Created by 58 on 2023/10/24.
//

#import <Foundation/Foundation.h>
#import "HTMLBaseTag.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ParserRegexrBlock)(HTMLBaseTag *htmlTag);

@interface HTMLParserTagRegex : NSObject

+ (void)enumerateMatchesInString:(NSString *)string block:(ParserRegexrBlock)block;

@end

NS_ASSUME_NONNULL_END
