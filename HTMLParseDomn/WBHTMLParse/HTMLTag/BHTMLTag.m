//
//  BHTMLTag.m
//  123456
//
//  Created by 58 on 2023/10/25.
//

#import "BHTMLTag.h"
#import "HTMLTagFactory.h"

@implementation BHTMLTag

- (NSDictionary *)attributes {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:[super attributes]];
    [params addEntriesFromDictionary:@{KHTMLFONTNAME:KHTMLTAGBDEFALUTFONTNAME}];
    return params;
}

@end
