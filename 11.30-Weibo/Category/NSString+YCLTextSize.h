//
//  NSString+YCLTextSize.h
//  11.06-QQ
//
//  Created by Chenglin Yu on 14/11/6.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YCLTextSize)
/**
 *    根据字体计算占用矩形的尺寸
 *
 *    @param font 字体
 *    @param size 限制最大尺寸
 *
 *    @return 文字占据矩形的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size;
@end
