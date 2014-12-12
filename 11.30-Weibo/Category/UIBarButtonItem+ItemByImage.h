//
//  UIBarButtonItem+ItemByImage.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ItemByImage)

/**
 *    更具传入图片尺寸，创建同等尺寸的barItem
 *
 *    @param normal      正常图片名称
 *    @param highlighted 高亮图片名称
 *    @param target      目标
 *    @param action      动作
 *
 *    @return UIBarButtonItem
 */
+ (instancetype)itemWithImageName:(NSString *)normal hightedImageName:(NSString *)highlighted target:(id)target action:(SEL)action;
@end
