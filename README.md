###用于H5调用原生展示的自定义密码键盘。参考了这位大侠的仿招行的键盘，稍作了修改。[NHKeyboardPro](https://github.com/iFindTA/NHKeyboardPro)


####效果
![1.gif](http://upload-images.jianshu.io/upload_images/810907-d1f4a2fc1dce81e5.gif?imageMogr2/auto-orient/strip)

* ## 结合webView使用的方式

```objc

// 可以是web端通过交互，调用原生的功能来实现键盘的弹出
- (IBAction)showABC:(id)sender
{
    self.input = [SafeKBInputView shareKBInputViewWithTypeABC];
    self.input.InputViewDelegate = self;
    [self.input show];
}

#pragma mark - delegate
// 每次文本框字符修改后 触发的代理方法，
// 提供一个真实字符串、一个占位符字符串
- (void)safeKBInputView:(SafeKBInputView *)inputView 			DidChangeText:(NSString *)text 
		 placeholderText:(NSString *)placeholder 
				TextField:(SafeTextField *)textField
{
	// 此处可以调用js 让web的文本框做出实时的改变
    self.lblWebpwd.text = placeholder;
    self.lblWebpwdTrue.text = text;
}

```

* ## 普通的使用方式
我用了一个自定义了textField管理了一些功能，再用一个KBInputView来管理弹出。如果原生客户端直接使用的话，可以直接用keyboard。

##SafeKBInputView
```objc
@property (nonatomic, strong) SafeTextField *textField;
@property (nonatomic, copy) NSMutableString *placeholderText;
@property (nonatomic, copy) NSString *trueText;
@property (nonatomic, weak) id<SafeKBInputViewDelegate> InputViewDelegate;
// 提供三个类别键盘的创建
+(SafeKBInputView *)shareKBInputViewWithTypeNum;
+(SafeKBInputView *)shareKBInputViewWithTypeNumDecimal;
+(SafeKBInputView *)shareKBInputViewWithTypeABC;

// 代理
@protocol SafeKBInputViewDelegate <NSObject>
-(void)safeKBInputView:(SafeKBInputView *)inputView DidChangeText:(NSString *)text placeholderText:(NSString *)placeholder TextField:(SafeTextField *)textField;

```
将web端的输入控件交互属性关闭，这样就不会弹出系统的键盘了。然后点击时让原生创建inputView，show出键盘，通过代理去调用js，实时修改控件的显示值。


####简单的使用可以直接使用keyboard这个View。或者使用SafeTextField，我在里面加了一些处理。使用H5调用的话可以使用SafeKBInputView，里面包了一个textField，用于显示键盘。
---------

---

###04/11
> ######今天添加了一个webView调用的demo，代码都在一块，发现一个问题。就是在show键盘的时候注意要用主线程去操作，这个问题也是之前使用JavaScriptCore中说到要注意的问题。

![2.gif](http://upload-images.jianshu.io/upload_images/810907-446268d8bb461e51.gif?imageMogr2/auto-orient/strip)



###要是哪里有什么不对的地方，还请及时的纠正，先谢过。