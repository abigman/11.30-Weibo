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

@interface YCLComposeController () <YCLToolBarDelegate, UITextViewDelegate>
/** textView */
@property (weak, nonatomic) UITextView *textView;
@end

@implementation YCLComposeController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavagationBarItem];
    
    // 设置 textView
    [self setupTextView];
    
    // 设置 toolBar
    [self setupToolBar];
  
}

/**
 *    设置 textView
 */
- (void)setupTextView {
    YCLTextView *textView = [[YCLTextView alloc] initWithFrame:CGRectMake(0, 0, 375, 264)];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:40];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

/**
 *    设置toolBar
 */
- (void)setupToolBar {
    // 添加工具条
    YCLToolBar *toolBar = [YCLToolBar toolBar];
    toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    toolBar.delegate = self;
    self.textView.inputAccessoryView = toolBar;
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

#pragma mark - UIScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView endEditing:YES];
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
