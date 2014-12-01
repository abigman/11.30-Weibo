//
//  UIView+YCLGeometry.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "UIView+YCLGeometry.h"

@implementation UIView (YCLGeometry)

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect currentFrame = self.frame;
    currentFrame.origin.x = x;
    self.frame = currentFrame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect currentFrame = self.frame;
    currentFrame.origin.y = y;
    self.frame = currentFrame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect currentFrame = self.frame;
    currentFrame.size.width = width;
    self.frame = currentFrame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect currentFrame = self.frame;
    currentFrame.size.height = height;
    self.frame = currentFrame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect currentFrame = self.frame;
    currentFrame.size = size;
    self.frame = currentFrame;
}

@end
