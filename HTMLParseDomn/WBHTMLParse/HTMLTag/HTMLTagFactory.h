//
//  HTMLTagFactory.h
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import <Foundation/Foundation.h>
#import "HTMLTagHeader.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const KHTMLB;
extern NSString *const KHTMLFONT;
extern NSString *const KHTMLTEXT;
extern NSString *const KHTMLNEWLINE;

extern NSString *const KHTMLTAGBDEFALUTFONTNAME;

extern NSDictionary const *KHTMLTAGFACTORY;
extern NSDictionary const *KDEFAULTFONTCONFIG;

@interface HTMLTagFactory : NSObject

@end

NS_ASSUME_NONNULL_END
