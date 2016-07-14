//
//  JsObjCModel.m
//  WebViewJavascript
//
//  Created by 谈Xx on 16/3/18.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "JsObjCModel.h"

@implementation JsObjCModel


- (void)callKeyboard:(NSDictionary *)info
{
    NSString *type = [info objectForKey:@"type"];
    
    // 默认带工具条切换键盘
    if ([type isEqualToString:@"all"])
    {
        self.input = [SafeKBInputView shareKBInputViewWithTypeAll];
    }
    // 数字键盘
    else if ([type isEqualToString:@"num"])
    {
        self.input = [SafeKBInputView shareKBInputViewWithTypeNum];
    }
    // 字母键盘
    else if ([type isEqualToString:@"abc"])
    {
        self.input = [SafeKBInputView shareKBInputViewWithTypeAll];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        [self.input show];
    });
    self.input.InputViewDelegate = self;
    self.input.dicInfo = info;

}


#pragma mark - SafeKBInputViewDelegate
- (void)safeKBInputViewDidChangeText:(SafeKBInputView *)inputView
{
    NSString *encodeStr = [inputView.trueText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]];
    
    NSString *js = [NSString stringWithFormat:@"var field = document.getElementById('%@'); field.value= '%@'; var btn = document.getElementById('button'); var te = \"%@\"; te = decodeURIComponent(te); btn.value= te; ",self.textId,inputView.placeholderText,encodeStr ];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"%@",inputView.trueText);
}

@end
