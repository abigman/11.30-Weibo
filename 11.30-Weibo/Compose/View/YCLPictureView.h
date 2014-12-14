//
//  YCLPictureView.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/13.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCLPictureView : UIView
/**
 *    添加一张图片
 *
 *    @param image 图片
 */
- (void)addImage:(UIImage *)image;
/**
 *    图片数组
 *
 *    @return 图片数组
 */
- (NSArray *)images;
@end
