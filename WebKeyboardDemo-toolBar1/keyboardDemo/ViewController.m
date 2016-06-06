//
//  ViewController.m
//  keyboardDemo
//
//  Created by 谈Xx on 16/4/11.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JsObjCModel.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *Web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView = Web;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:    [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]]];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    JsObjCModel *model  = [[JsObjCModel alloc] init];
    // 模型
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    model.webEngine = self;
    // 增加异常的处理
    self.jsContext.exceptionHandler = ^(JSContext *context,
                                        JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}



@end
