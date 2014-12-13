//
//  YCLComposeController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/8.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLComposeController.h"
#import "YCLTextView.h"
#import "YCLToolBar.h"
#import "YCLPictureView.h"
#import "UIView+YCLGeometry.h"

@interface YCLComposeController () <YCLToolBarDelegate, UITextViewDelegate>
/** textView */
@property (weak, nonatomic) UITextView *textView;
/** toolBar */
@property (weak, nonatomic) UIView *toolBar;
/** pictureView */
@property (weak, nonatomic) YCLPictureView *pictureView;

@end

@implementation YCLComposeController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavagationBarItem];
    
    // 设置 textView
    [self setupTextView];
    
    
    // 设置 pictureView
    [self setupPictureView];
    
    // 设置 toolBar
    [self setupToolBar];
    
    // 监听键盘
    [self observeKeyboard];
}

/**
 *    设置 textView
 */
- (void)setupTextView {
    YCLTextView *textView = [[YCLTextView alloc] init];
    textView.frameW = self.view.frameW;
    textView.frameH = self.view.frameH - 44;
//    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:40];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    [self.textView becomeFirstResponder];
}

/**
 *    设置toolBar
 */
- (void)setupToolBar {
    // 添加工具条
    YCLToolBar *toolBar = [YCLToolBar toolBar];
    toolBar.frameW = self.view.frameW;
    toolBar.frameH = 44;
    toolBar.delegate = self;
    toolBar.frameY = self.view.frameH - toolBar.frameH;
    [self.view addSubview:toolBar];
    
    self.toolBar = toolBar;
    
}

- (void)setupPictureView {
    YCLPictureView *pictureView = [[YCLPictureView alloc] init];
    pictureView.backgroundColor = [UIColor redColor];
    pictureView.frameW = self.view.frameW;
    pictureView.frameH = self.view.frameW;
    pictureView.frameY = self.navigationController.navigationBar.frameH + 200;
    [self.view addSubview:pictureView];
    self.pictureView = pictureView;
}

/**
 *    设置导航栏按钮
 */
- (void)setupNavagationBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    NSLog(@"发送微博");
}

/**
 *    监听键盘弹出
 */
- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhidden:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGFloat keyboardYBegin = [notification.userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue].origin.y;
    CGFloat keyboardYEnd = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
    
    CGFloat length = keyboardYBegin - keyboardYEnd;
    
    NSLog(@"length = %f", length);
    self.toolBar.frameY += -length;
    self.textView.frameY += -length;
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    /**
     *    
     {
         name = UIKeyboardWillShowNotification;
         userInfo = {
             UIKeyboardAnimationCurveUserInfoKey = 7;
             UIKeyboardAnimationDurationUserInfoKey = "0.25";
             UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
             UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
             UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
             UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
             UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
         }
     }
     */

    CGRect boardBounds= [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    CGFloat boardH = boardBounds.size.height;
    NSLog(@"%f", boardH);
    self.toolBar.frameY -= boardH;
    self.textView.frameH += -boardH;

}
- (void)keyboardWillhidden:(NSNotification *)notification {
    CGRect boardBounds= [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    CGFloat boardH = boardBounds.size.height;
    NSLog(@"%f", boardH);
    self.toolBar.frameY += boardH;
    self.textView.frameH -= -boardH;
}


#pragma mark - UIScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.textView endEditing:YES];
    
    [self.textView resignFirstResponder];
}

#pragma mark - YCLToolBarDelegate

- (void)toolBar:(YCLToolBar *)toolBar didClickedButtonWithType:(YCLComposeToolBarButtonType)type {
    switch (type) {
        case YCLComposeToolBarButtonTypeCamera:
            NSLog(@"相机");
            break;
        case YCLComposeToolBarButtonTypePicture:
            NSLog(@"图片");
            break;
        case YCLComposeToolBarButtonTypeTrend:
            NSLog(@"话题");
            break;
        case YCLComposeToolBarButtonTypeEmotion:
            NSLog(@"表情");
            break;
        case YCLComposeToolBarButtonTypeMention:
            NSLog(@"点名");
            break;
        case YCLComposeToolBarButtonTypeLocate:
            NSLog(@"定位");
            break;
    }
}
@end
