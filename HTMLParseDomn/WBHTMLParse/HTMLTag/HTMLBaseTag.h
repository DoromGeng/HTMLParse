//
//  HTMLBaseTag.h
//  123456
//
//  Created by 58 on 2023/10/25.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HTMLTagType_none,
    HTMLTagType_string,
    HTMLTagType_startTag,
    HTMLTagType_closeTag,
    HTMLTagType_selfCloseTag
} HTMLTagType;

@interface HTMLBaseTag : NSObject

@property(nonatomic, assign) HTMLTagType tagType;
@property(nonatomic, copy  ) NSString *tagName;

@property(nonatomic, weak  ) HTMLBaseTag *parent;
@property(nonatomic, strong) NSMutableArray *childs;

@property(nonatomic, copy  ) NSDictionary *attributes;
@property(nonatomic, copy  ) NSString *string;
@property(nonatomic, copy  ) NSAttributedString *attributedString;

- (void)appendChild:(HTMLBaseTag *)child;

@end

NS_ASSUME_NONNULL_END
