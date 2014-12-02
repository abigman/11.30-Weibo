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
// 根据字体创建尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size;
@end
