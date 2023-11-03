# HTMLParse
## 方式
  
  NSString *string = @"111111<font color='#ff432e' name='PingFangSC-Regular'>搬家短途</font>; 
  
  self.label.attributedText = [HTMLParser parserString:string attributes:nil];
