//
//  JavaScriptObjectiveCDelegate.h
//  WebViewJavascript
//
//  Created by 谈Xx on 16/3/18.
//  Copyright © 2016年 谈Xx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>

- (void)callKeyboard:(NSDictionary *)info;

@end
