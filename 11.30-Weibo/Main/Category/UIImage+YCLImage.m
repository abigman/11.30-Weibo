//
//  UIImage+YCLImage.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "UIImage+YCLImage.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] < 8.0)

@implementation UIImage (YCLImage)

+ (UIImage *)imageWithName:(NSString *)imageName {
    UIImage *image = nil;
    // 如果有 _os7 后缀的图片，使用
    if (iOS7) {
        NSString *imageName_os7 = [imageName stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:imageName_os7];
    }
    
    // 如果没有，算了
    if (!image) {
        image = [UIImage imageNamed:imageName];
    }
    
    // 使用原图，不渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)resizableImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageWithName:imageName];
    CGSize imageSize = image.size;
    CGFloat capW = imageSize.width * 0.5;
    CGFloat capH = imageSize.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capH, capW, capH, capW) resizingMode:UIImageResizingModeStretch];
}
@end
