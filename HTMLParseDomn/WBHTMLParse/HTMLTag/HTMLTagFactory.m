//
//  HTMLTagFactory.m
//  123456
//
//  Created by 58 on 2023/10/26.
//

#import "HTMLTagFactory.h"
#import "BHTMLTag.h"
#import "FONTHTMLTag.h"
#import "TextHTMLTag.h"
#import "IMGHTMLTag.h"
#import "NEWLINEHTMLTag.h"

NSString *const KHTMLB = @"b";
NSString *const KHTMLFONT = @"font";
NSString *const KHTMLTEXT = @"text";
NSString *const KHTMLIMG = @"img";
NSString *const KHTMLNEWLINE = @"br";

NSString *const KHTMLTAGBDEFALUTFONTNAME = @"PingFangSC-Medium";

NSDictionary const *KHTMLTAGFACTORY;
NSDictionary const *KDEFAULTFONTCONFIG;

@implementation HTMLTagFactory

+ (void)load {
    KHTMLTAGFACTORY = @{
        KHTMLB: [BHTMLTag class],
        KHTMLFONT: [FONTHTMLTag class],
        KHTMLTEXT: [TextHTMLTag class],
        KHTMLIMG: [IMGHTMLTag class],
        KHTMLNEWLINE: [NEWLINEHTMLTag class],
    };
    
    KDEFAULTFONTCONFIG = @{
        KHTMLFONTSIZE:@"17",
        KHTMLFONTCOLOR:[UIColor blackColor]
    };
}

@end
