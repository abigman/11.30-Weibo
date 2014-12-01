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
    if (iOS7) {
        imageName = [imageName stringByAppendingString:@"_os7"];
    }
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)resizableImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageWithName:imageName];
    CGSize imageSize = image.size;
    CGFloat capW = imageSize.width * 0.5;
    CGFloat capH = imageSize.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capH, capW, capH, capW) resizingMode:UIImageResizingModeStretch];
}
@end
