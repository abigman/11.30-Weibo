//
//  UIView+YCLGeometry.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "UIView+YCLGeometry.h"

@implementation UIView (YCLGeometry)

- (CGFloat)frameX {
    return self.frame.origin.x;
}
- (void)setFrameX:(CGFloat)x {
    CGRect currentFrame = self.frame;
    currentFrame.origin.x = x;
    self.frame = currentFrame;
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}
- (void)setFrameY:(CGFloat)y {
    CGRect currentFrame = self.frame;
    currentFrame.origin.y = y;
    self.frame = currentFrame;
}

- (CGFloat)frameW {
    return self.frame.size.width;
}

- (void)setFrameW:(CGFloat)width {
    CGRect currentFrame = self.frame;
    currentFrame.size.width = width;
    self.frame = currentFrame;
}

- (CGFloat)frameH {
    return self.frame.size.height;
}

- (void)setFrameH:(CGFloat)height {
    CGRect currentFrame = self.frame;
    currentFrame.size.height = height;
    self.frame = currentFrame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint currentCenter = self.center;
    currentCenter.x = centerX;
    self.center = currentCenter;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGSize)frameS {
    return self.frame.size;
}

- (void)setFrameS:(CGSize)size {
    CGRect currentFrame = self.frame;
    currentFrame.size = size;
    self.frame = currentFrame;
}

@end
