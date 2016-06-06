//
//  SafeTextField.m
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/7.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "SafeTextField.h"

@implementation SafeTextField


- (instancetype)initWithkeyboardType:(SafeKeyboardType)type
{
    self = [super init];
    if (self) {
        self.KBType = type;
    }
    return self;
}
// 成为第一响应者
- (BOOL)becomeFirstResponder
{
    BOOL bflag = [super becomeFirstResponder];
    if(bflag)
    {
        SafeKeyboard *kb = (SafeKeyboard *)self.inputView;
        kb.inputSource = self;
        [kb setRandomNumberText];
    }
    return bflag;
}

- (BOOL)resignFirstResponder
{
    SafeKeyboard *kb = (SafeKeyboard *)self.inputView;
    kb.inputSource = nil;
    BOOL ret = [super resignFirstResponder];
    if (self.safeTextDelegate && [self.safeTextDelegate respondsToSelector:@selector(safeTextFieldDidResignFirstResponder:)])
    {
        [self.safeTextDelegate safeTextFieldDidResignFirstResponder:self];
    }
    return ret;
}

-(void)deleteBackward
{
    [super deleteBackward];
    if (self.safeTextDelegate && [self.safeTextDelegate respondsToSelector:@selector(safeTextFieldDidDeleteString:)])
    {
        [self.safeTextDelegate safeTextFieldDidDeleteString:self];
    }
}

#pragma mark - setter
-(void)setKBType:(SafeKeyboardType)KBType
{
    _KBType = KBType;
    SafeKeyboard *keyboard = [SafeKeyboard keyboardWithType:KBType];
    self.inputView = keyboard;
    keyboard.inputSource = self;
}

@end
