//
//  YCLHomeTitleButton.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLHomeTitleButton.h"
#import "NSString+YCLTextSize.h"
#import "UIView+YCLGeometry.h"

@implementation YCLHomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
//        self.imageView.backgroundColor = [UIColor blueColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.backgroundColor = [UIColor redColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
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

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    CGSize textSize = [title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
    self.frameW = textSize.width + self.frameH;
}
@end
