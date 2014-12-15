//
//  UIBarButtonItem+ItemByImage.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "UIBarButtonItem+ItemByImage.h"

@implementation UIBarButtonItem (ItemByImage)
+ (instancetype)itemWithImageName:(NSString *)normal hightedImageName:(NSString *)highlighted target:(id)target action:(SEL)action {
    UIButton *item = [[UIButton alloc] init];
    [item setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    CGSize size = item.currentImage.size;
    item.frame = CGRectMake(0, 0, size.width, size.height);
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

@end
