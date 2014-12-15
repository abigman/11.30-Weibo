//
//  UIView+YCLGeometry.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/1.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YCLGeometry)
/** x */
@property (assign, nonatomic) CGFloat frameX;
/** y */
@property (assign, nonatomic) CGFloat frameY;
/** width */
@property (assign, nonatomic) CGFloat frameW;
/** height */
@property (assign, nonatomic) CGFloat frameH;
/** centerX */
@property (assign, nonatomic) CGFloat centerX;
/** centerY */
@property (assign, nonatomic) CGFloat centerY;
/** size */
@property (assign, nonatomic) CGSize frameS;
@end
