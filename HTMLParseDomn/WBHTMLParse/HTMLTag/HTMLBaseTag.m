//
//  HTMLBaseTag.m
//  123456
//
//  Created by 58 on 2023/10/25.
//

#import "HTMLBaseTag.h"

@implementation HTMLBaseTag

- (instancetype)init {
    self = [super init];
    if (self) {
        _childs = [NSMutableArray array];
    }
    return self;
}

- (void)appendChild:(HTMLBaseTag *)child {
    if(child) {
        child.parent = self;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params addEntriesFromDictionary:self.attributes];
        [params addEntriesFromDictionary:child.attributes];
        child.attributes = params;
        [_childs addObject:child];
    }
}

@end
