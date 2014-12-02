//
//  UIImage+YCLImage.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YCLImage)
// iOS7 选择带 _os7 后缀的图片
+ (UIImage *)imageWithName:(NSString *)imageName;
// 可拉伸图片
+ (UIImage *)resizableImageNamed:(NSString *)imageName;
@end
