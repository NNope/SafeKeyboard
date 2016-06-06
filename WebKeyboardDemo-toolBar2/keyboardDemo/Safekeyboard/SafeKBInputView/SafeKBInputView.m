//
//  SafeKBInputView.m
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/8.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "SafeKBInputView.h"

static SafeKBInputView* keyboardInputViewInstance = nil;
static SafeKBInputView* keyboardViewTypeNumDecimalInstance = nil;
static SafeKBInputView* keyboardViewTypeNumInstance = nil;
static SafeKBInputView* keyboardViewTypeABCInstance = nil;
@implementation SafeKBInputView

// 默认可切换键盘
+(SafeKBInputView *)shareKBInputViewWithTypeAll
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyboardInputViewInstance = [[SafeKBInputView alloc] initWithSafeKeyboardType:SafeKeyboardTypeAll];
    });
    return keyboardInputViewInstance;
}
// 数字
+(SafeKBInputView *)shareKBInputViewWithTypeNum
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyboardViewTypeNumInstance = [[SafeKBInputView alloc] initWithSafeKeyboardType:SafeKeyboardTypeNum];
    });
    return keyboardViewTypeNumInstance;
}
// 数字+小数点
+(SafeKBInputView *)shareKBInputViewWithTypeNumDecimal
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyboardViewTypeNumDecimalInstance = [[SafeKBInputView alloc] initWithSafeKeyboardType:SafeKeyboardTypeNumDecimal];
    });
    return keyboardViewTypeNumDecimalInstance;
}
// 字母
+(SafeKBInputView *)shareKBInputViewWithTypeABC
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyboardViewTypeABCInstance = [[SafeKBInputView alloc] initWithSafeKeyboardType:SafeKeyboardTypeABC];
    });
    return keyboardViewTypeABCInstance;
}

- (instancetype)initWithSafeKeyboardType:(SafeKeyboardType)type
{
    self = [super init];
    if (self) {
        self.textField = [[SafeTextField alloc] init];
        self.textField.KBType = type;
        self.textField.delegate = self;
        self.textField.safeTextDelegate = self;
        self.trueText = @"";
        [self addSubview:self.textField];
    }
    return self;
}

- (void)show
{
    UIViewController *topVC = [self getCurrentVC];
    [topVC.view addSubview:self];
    [self.textField becomeFirstResponder];
    self.textField.text = @"";
    self.trueText = @"";
    self.placeholderText = [NSMutableString string];
}

#pragma mark - delegate

// textfield 取消第一响应者 ，view消失
- (void)safeTextFieldDidResignFirstResponder:(SafeTextField *)textField
{
    [self removeFromSuperview];
}

// 删除
- (void)safeTextFieldDidDeleteString:(SafeTextField *)textField
{
    _placeholderText  = [NSMutableString string];
    NSInteger len = textField.text.length;
    for (int i = 0; i < len; i++)
    {
        [self.placeholderText appendString:@"●"];
    }
    self.trueText = textField.text;
    
    
    if (self.InputViewDelegate && [self.InputViewDelegate respondsToSelector:@selector(safeKBInputViewDidChangeText:)])
    {
        [self.InputViewDelegate safeKBInputViewDidChangeText:self];
    }
}

// 增加
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _placeholderText  = [NSMutableString string];
    NSInteger len = textField.text.length + 1;
    for (int i = 0; i < len; i++)
    {
        [self.placeholderText appendString:@"●"];
    }
    self.trueText = [self.trueText stringByAppendingString:string];
    
    
    if (self.InputViewDelegate && [self.InputViewDelegate respondsToSelector:@selector(safeKBInputViewDidChangeText:)])
    {
        [self.InputViewDelegate safeKBInputViewDidChangeText:self];
    }
    return YES;
}

#pragma mark - getter setter

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
