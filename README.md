# HTMLParse
## 使用方式
  NSString *checkString = @"<img src='https://wos.58cdn.com.cn/cDazYxWcDHJ/picasso/c8m6fpum__w204_h80.png' width='50' height='20'></img>111111<font color='#ff432e' name='PingFangSC-Regular'>搬家短途</font>|<font color='#ff552e'>短途搬家</font>|<font color='#ff552e'>货车货车搬家</font>李托运李托运车托动车托 摩托车托运 汽车托运</font>";
  self.label.attributedText = [HTMLParser parserString:checkString attributes:nil];
