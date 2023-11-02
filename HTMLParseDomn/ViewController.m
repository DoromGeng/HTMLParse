//
//  ViewController.m
//  HTMLParseDomn
//
//  Created by 58 on 2023/11/2.
//

#import "ViewController.h"
#import "HTMLParser.h"
#import "YYLabel.h"

@interface ViewController ()

@property (nonatomic, strong) YYLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupLabel {
    
    NSString *checkString = @"<img src='https://wos.58cdn.com.cn/cDazYxWcDHJ/picasso/c8m6fpum__w204_h80.png' width='50' height='20'></img>111111<font color='#ff432e' name='PingFangSC-Regular'>搬家短途</font>|<font color='#ff552e'>短途搬家</font>|<font color='#ff552e'>货车货车搬家</font>李托运李托运车托动车托 摩托车托运 汽车托运</font>";
    
    NSTimeInterval start = CFAbsoluteTimeGetCurrent();
    self.label.attributedText = [HTMLParser parserString:checkString attributes:nil];
    
    NSLog(@"耗时 %f", (CFAbsoluteTimeGetCurrent() - start)*1000);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setupLabel];
}

- (YYLabel *)label {
    if(!_label) {
        _label = [[YYLabel alloc] initWithFrame:self.view.bounds];
        _label.numberOfLines = 0;
        [self.view addSubview:_label];
    }
    return _label;
}

@end
