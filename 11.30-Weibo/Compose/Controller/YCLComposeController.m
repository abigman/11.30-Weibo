//
//  YCLComposeController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/8.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLComposeController.h"
#import "YCLTextView.h"

@implementation YCLComposeController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavagationBarItem];
    //
    YCLTextView *textView = [[YCLTextView alloc] initWithFrame:CGRectMake(0, 0, 375, 264)];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:40];
//    textView.placeholder = @"ABCDE";
    [self.view addSubview:textView];
}

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
@end
