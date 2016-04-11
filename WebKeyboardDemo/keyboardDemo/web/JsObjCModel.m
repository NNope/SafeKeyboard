//
//  JsObjCModel.m
//  WebViewJavascript
//
//  Created by 谈Xx on 16/3/18.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "JsObjCModel.h"

@implementation JsObjCModel


- (void)callKeyboard:(NSString *)textId Type:(NSString *)type
{
    self.textId = textId;
    if ([type isEqualToString:@"abc"])
    {
        self.input = [SafeKBInputView shareKBInputViewWithTypeABC];
    }
    else if ([type isEqualToString:@"num"])
    {
        self.input = [SafeKBInputView shareKBInputViewWithTypeNum];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        [self.input show];
    });
    self.input.InputViewDelegate = self;
    
}

#pragma mark - SafeKBInputViewDelegate
- (void)safeKBInputView:(SafeKBInputView *)inputView DidChangeText:(NSString *)text placeholderText:(NSString *)placeholder TextField:(SafeTextField *)textField
{
    NSString *js = [NSString stringWithFormat:@"var field = document.getElementById('%@'); field.value= '%@'; var btn = document.getElementById('button'); btn.value= '%@';",self.textId,placeholder,text];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}


@end
