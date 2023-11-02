//
//  NSTextCheckingResult+Tool.m
//  123456
//
//  Created by 58 on 2023/10/25.
//

#import "NSTextCheckingResult+Tool.h"

@implementation NSTextCheckingResult (Tool)

- (NSString *)subString:(NSString *)string name:(NSString *)name {
    if(name.length > 0) {
        NSRange range = [self rangeWithName:name];
        if(range.location != NSNotFound) {
            return [string substringWithRange:range];
        }
    }
    return nil;
}

@end
