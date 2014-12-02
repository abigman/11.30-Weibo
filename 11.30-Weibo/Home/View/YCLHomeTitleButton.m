//
//  YCLHomeTitleButton.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLHomeTitleButton.h"

@implementation YCLHomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH = self.frame.size.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.frame.size.width - imageH;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width - self.frame.size.height;
    CGFloat titleH = self.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
