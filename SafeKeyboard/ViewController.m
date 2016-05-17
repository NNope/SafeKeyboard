//
//  ViewController.m
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/6.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import "ViewController.h"
#import "SafeTextField.h"
#import "SafeKBInputView.h"

@interface ViewController ()<SafeKBInputViewDelegate>
/**
 *  占位符
 */
@property (weak, nonatomic) IBOutlet UILabel *lblWebpwd;
@property (weak, nonatomic) IBOutlet UILabel *lblWebnum;
@property (weak, nonatomic) IBOutlet UILabel *lblWebnumDecimal;
/**
 *  真实内容
 */
@property (weak, nonatomic) IBOutlet UILabel *lblWebpwdTrue;
@property (weak, nonatomic) IBOutlet UILabel *lblWebnumTrue;
@property (weak, nonatomic) IBOutlet UILabel *lblWebnumDecimalTrue;

@property (nonatomic, strong) SafeKBInputView *input;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)showABC:(id)sender
{
    self.input = [SafeKBInputView shareKBInputViewWithTypeAll];
    self.input.InputViewDelegate = self;
    [self.input show];
    
    
}

- (IBAction)showNum:(id)sender
{
    self.input = [SafeKBInputView shareKBInputViewWithTypeNum];
    self.input.InputViewDelegate = self;
    [self.input show];
}

- (IBAction)showNumDecimal:(id)sender
{
    self.input = [SafeKBInputView shareKBInputViewWithTypeNumDecimal];
    self.input.InputViewDelegate = self;
    [self.input show];
}

#pragma mark - delegate

- (void)safeKBInputViewDidChangeText:(SafeKBInputView *)inputView
{
    switch (inputView.textField.KBType)
    {
        case SafeKeyboardTypeABC:
        {
            self.lblWebpwd.text = inputView.placeholderText;
            self.lblWebpwdTrue.text = inputView.trueText;
        }
            break;
        case SafeKeyboardTypeAll:
        {
            self.lblWebpwd.text = inputView.placeholderText;
            self.lblWebpwdTrue.text = inputView.trueText;
        }
            break;
        case SafeKeyboardTypeNum:
        {
            self.lblWebnum.text = inputView.placeholderText;
            self.lblWebnumTrue.text = inputView.trueText;
        }
            break;
        case SafeKeyboardTypeNumDecimal:
        {
            self.lblWebnumDecimal.text = inputView.placeholderText;
            self.lblWebnumDecimalTrue.text = inputView.trueText;
        }
            break;
            
        default:
            break;
    }
}
@end
