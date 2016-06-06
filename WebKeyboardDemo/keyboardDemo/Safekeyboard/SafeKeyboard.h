//
//  SafeKeyboard.h
//  SafeKeyboard
//
//  Created by 谈Xx on 16/4/6.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    NHKBImageLeft = 0,
    NHKBImageInner,
    NHKBImageRight,
    NHKBImageMax
};

typedef NS_ENUM(NSInteger,SafeKeyboardType){
    SafeKeyboardTypeAll         = 1 << 0,
    SafeKeyboardTypeNum         = 1 << 1,
    SafeKeyboardTypeNumDecimal  = 1 << 2,
    SafeKeyboardTypeABC         = 1 << 3,
    SafeKeyboardTypeSymbol      = 1 << 4
};

@interface SafeKeyboard : UIView

/**
 *  logo
 */
@property (nonatomic,copy) NSString *icon;

/**
 *  title
 */
@property (nonatomic,copy) NSString *enterprise;

/*!
 *  @brief such as UITextField,UITextView,UISearchBar
 */
@property (nonatomic,strong) UIView *inputSource;

+ (instancetype)keyboardWithType:(SafeKeyboardType)type;

// 设置键盘文字
- (void)setRandomNumberText;

//+ (SafeKeyboard *)shareKeyboardViewWithType:(KeyboardType)type;
@end
