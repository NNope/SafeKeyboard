//
//  SafeTextField.h
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/7.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafeKeyboard.h"
@class SafeTextField;

@protocol SafeTextFieldDelegate <NSObject>
// 点击完成 键盘消失
-(void)safeTextFieldDidResignFirstResponder:(SafeTextField *)textField;
// 删除字符 inputView需要知道，并传递给web
-(void)safeTextFieldDidDeleteString:(SafeTextField *)textField;

@end

@interface SafeTextField : UITextField

@property (nonatomic, assign) SafeKeyboardType KBType;
@property (nonatomic, weak) id<SafeTextFieldDelegate> safeTextDelegate;

- (instancetype)initWithkeyboardType:(SafeKeyboardType)type;
@end
