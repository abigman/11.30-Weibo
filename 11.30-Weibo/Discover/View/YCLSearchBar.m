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
        
        self.background = [UIImage resizableImageNamed:@"navigationbar_filter_background"];
//        self.backgroundColor = [UIColor greenColor];
        
        UIButton *leftView = [[UIButton alloc] init];
        [leftView setImage:[UIImage imageWithName:@"navigationbar_search"] forState:UIControlStateNormal];
        [leftView setImage:[UIImage imageWithName:@"navigationbar_search_highlighted"] forState:UIControlStateHighlighted];
        leftView.imageView.contentMode = UIViewContentModeCenter;
        leftView.height = leftView.currentImage.size.height + 5;
        leftView.width = leftView.height;
//        leftView.backgroundColor = [UIColor redColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc] init];
}
@end
