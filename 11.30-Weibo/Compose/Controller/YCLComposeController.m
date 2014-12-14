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
#import "AFNetworking.h"
#import "YCLAccount.h"
#import "YCLAccountTool.h"

@interface YCLComposeController () <YCLToolBarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
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

    // 设置 textView
    [self setupTextView];
    
    
    // 设置 pictureView
    [self setupPictureView];
    
    // 设置 toolBar
    [self setupToolBar];
    
    // 通知
    [self addObserver];
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


/**
 *    设置 pictureView
 */
- (void)setupPictureView {
    YCLPictureView *pictureView = [[YCLPictureView alloc] init];
//    pictureView.backgroundColor = [UIColor redColor];
    pictureView.frameW = self.view.frameW;
    pictureView.frameH = self.view.frameW;
    pictureView.frameY = self.navigationController.navigationBar.frameH + 200;
    [self.textView addSubview:pictureView];
    self.pictureView = pictureView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavagationBarItem];
}

/**
 *    设置导航栏按钮
 */
- (void)setupNavagationBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    NSLog(@"发送微博");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *requestParas = [NSMutableDictionary dictionary];
    
    YCLAccount *account = [YCLAccountTool readAccount];
    requestParas[@"access_token"] = account.access_token;
    requestParas[@"status"] = self.textView.text;
//    requestParas[@"pic"] = ((UIImageView *)[self.pictureView.subviews firstObject]).image;
    
    [manager POST:@"https://upload.api.weibo.com/2/statuses/update.json" parameters:requestParas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"微博发送成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"微博发送失败 %@", error);
    }];
}

/**
 *    通知
 */
- (void)addObserver {
    // 监听键盘弹出/隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhidden:) name:UIKeyboardWillHideNotification object:nil];
    
    // 监听textView文字变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
- (void)textViewTextDidChange:(NSNotification *)notification {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length != 0;
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
            [self openAlbum];
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

- (void)openAlbum {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.pictureView addImage:image];
}
@end
