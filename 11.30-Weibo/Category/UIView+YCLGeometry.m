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

//- (CGSize)size {
//    return self.frame.size;
//}
//
//- (void)setSize:(CGSize)size {
//    CGRect currentFrame = self.frame;
//    currentFrame.size = size;
//    self.frame = currentFrame;
//}

@end
