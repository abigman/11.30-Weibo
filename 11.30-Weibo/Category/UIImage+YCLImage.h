//
//  UIImage+YCLImage.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YCLImage)
+ (UIImage *)imageWithName:(NSString *)imageName;
+ (UIImage *)resizableImageNamed:(NSString *)imageName;
@end
