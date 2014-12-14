//
//  YCLPictureView.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/13.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLPictureView.h"
#import "UIView+YCLGeometry.h"

@implementation YCLPictureView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 10;
    int maxColumns = 3;
    CGFloat imageW = (self.frameW - (maxColumns + 1) * margin) / maxColumns;
    CGFloat imageH = imageW;
    
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        int row = i / maxColumns;
        int column = i % maxColumns;
        imageView.frameX = margin + column * (imageW + margin);
        imageView.frameY = margin + row * (imageH + margin);
        imageView.frameW = imageW;
        imageView.frameH = imageH;
        
        if (8 == i) {
            break;
        }
    }
}

- (void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (NSArray *)images {
    NSMutableArray *imagesM = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (UIImageView *imageView in self.subviews) {
        UIImage *image = imageView.image;
        [imagesM addObject:image];
    }
    return [imagesM copy];
}

@end
