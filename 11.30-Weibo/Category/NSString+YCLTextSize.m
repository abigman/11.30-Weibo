//
//  NSString+YCLTextSize.m
//  11.06-QQ
//
//  Created by Chenglin Yu on 14/11/6.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "NSString+YCLTextSize.h"

@implementation NSString (YCLTextSize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}
@end
