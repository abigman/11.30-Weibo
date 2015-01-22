//
//  YCLStatusPicturesView.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/19.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusPicturesView.h"
#import "MJExtension.h"
#import "YCLStatusPictureView.h"
#import "YCLPicture.h"
#import "UIImageView+WebCache.h"
#import "YCLStatusStyle.h"

@interface YCLStatusPicturesView ()
/** 图片视图数组 */
@property (strong, nonatomic) NSMutableArray *pictureViews;
/** d */

@end

@implementation YCLStatusPicturesView

// 告诉编译器 该属性保存的对象类型
- (NSDictionary *)objectClassInArray {
    return @{@"pictures" : [YCLStatusPictureView class]};
}

- (NSMutableArray *)pictureViews {
    if (!_pictureViews) {
        _pictureViews = [NSMutableArray array];
    }
    return _pictureViews;
}


- (void)setPictures:(NSArray *)pictures {
    _pictures = pictures;
    
    // 显示几行
    int showColumns = kImageColumns;
    CGFloat padding = kImageMargin;
    CGFloat viewWH = kImageWH;
    
    // 根据图片数，添加对应数量的view
    // 先清空之前的视图
    for (UIView *picView in self.subviews) {
        [picView removeFromSuperview];
    }
    
    for (int i = 0; i<pictures.count; i++) {
        YCLStatusPictureView *pictureView = [[YCLStatusPictureView alloc] init];
        int row = i / showColumns;
        int column = i % showColumns;
        CGFloat viewX = (viewWH + padding) * column;
        CGFloat viewY =(viewWH + padding) * row;
        if (1 == pictures.count) {
            pictureView.frame = CGRectMake(viewX, viewY, viewWH*2+kImageMargin , viewWH*2+kImageMargin);
        } else {
            pictureView.frame = CGRectMake(viewX, viewY, viewWH, viewWH);
        }
        
        [pictureView sd_setImageWithURL:[NSURL URLWithString:[pictures[i] thumbnail_pic]] placeholderImage:[UIImage imageNamed:@"common_loading"]];
        pictureView.contentMode = UIViewContentModeScaleAspectFill;
        pictureView.clipsToBounds = YES;
        
        [self addSubview:pictureView];
        
        [self.pictureViews addObject:pictureView];
    }
}



@end
