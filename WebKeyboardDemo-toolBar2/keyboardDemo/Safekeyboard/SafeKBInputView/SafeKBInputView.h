//
//  SafeKBInputView.h
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/8.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafeTextField.h"
@class SafeKBInputView;

// 点击的代理事件 传递到外层
@protocol SafeKBInputViewDelegate <NSObject>
// 每次输入的代理事件
-(void)safeKBInputViewDidChangeText:(SafeKBInputView *)inputView;


@end

@interface SafeKBInputView : UIView<SafeTextFieldDelegate,UITextFieldDelegate>

@property (nonatomic, strong) SafeTextField *textField;
@property (nonatomic, copy) NSMutableString *placeholderText;
@property (nonatomic, copy) NSString *trueText;

@property (nonatomic, weak) id<SafeKBInputViewDelegate> InputViewDelegate;

/**
 *  带字母 字符 数字切换工具条
 */
+(SafeKBInputView *)shareKBInputViewWithTypeAll;
/**
 *  数字
 */
+(SafeKBInputView *)shareKBInputViewWithTypeNum;
/**
 *  数字+小数点
 */
+(SafeKBInputView *)shareKBInputViewWithTypeNumDecimal;
/**
 *  字母+符号
 */
+(SafeKBInputView *)shareKBInputViewWithTypeABC;
- (instancetype)initWithSafeKeyboardType:(SafeKeyboardType)type;
// 显示
-(void)show;

@end
