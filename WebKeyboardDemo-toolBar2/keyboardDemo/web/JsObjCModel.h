//
//  JsObjCModel.h
//  WebViewJavascript
//
//  Created by 谈Xx on 16/3/18.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JavaScriptObjectiveCDelegate.h"
#import "SafeKBInputView.h"
#import "ViewController.h"

@interface JsObjCModel : NSObject<JavaScriptObjectiveCDelegate,SafeKBInputViewDelegate>
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) SafeKBInputView *input;
@property (nonatomic,weak) ViewController *webEngine;

@property (nonatomic, strong) NSString *textId;
@end
