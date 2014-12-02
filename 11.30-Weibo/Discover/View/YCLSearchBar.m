//
//  YCLSearchBar.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLSearchBar.h"
#import "UIView+YCLGeometry.h"
#import "UIImage+YCLImage.h"

@implementation YCLSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.background = [UIImage resizableImageNamed:@"navigationbar_filter_background"];
//        self.backgroundColor = [UIColor greenColor];
        
        UIButton *leftView = [[UIButton alloc] init];
        [leftView setImage:[UIImage imageWithName:@"navigationbar_search"] forState:UIControlStateNormal];
        [leftView setImage:[UIImage imageWithName:@"navigationbar_search_highlighted"] forState:UIControlStateHighlighted];
        // 图片居中
        leftView.imageView.contentMode = UIViewContentModeCenter;
        leftView.frameH = leftView.currentImage.size.height;
        leftView.frameW = leftView.frameH;
//        leftView.backgroundColor = [UIColor redColor];
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.placeholder = @"搜一下又不会怀孕";
    }
    return self;
}

//- (CGRect)textRectForBounds:(CGRect)bounds {
//    CGFloat textX = CGRectGetMaxX(self.leftView.frame);
//    CGFloat textY = 0;
//    CGFloat textW = self.frameW - self.frameH;
//    CGFloat textH = self.frameH;
//    return CGRectMake(textX, textY, textW, textH);
//}

+ (instancetype)searchBar {
    return [[self alloc] init];
}
@end
