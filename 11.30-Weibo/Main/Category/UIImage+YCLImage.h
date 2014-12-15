//
//  UIImage+YCLImage.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YCLImage)
/**
 *    如果是iOS7系统，自动选取名称带_os7后缀的图片
 *
 *    @param imageName 图片名称
 *
 *    @return 名称带_os7后缀的图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName;

/**
 *    返回可拉伸的图片
 *
 *    @param imageName 图片名
 *
 *    @return 可拉伸的图片
 */
+ (UIImage *)resizableImageNamed:(NSString *)imageName;
@end
