//
//  YCLStatusCellView.h
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/16.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCLStatusFrame;

@interface YCLStatusCell : UITableViewCell
/** 微博frame数据 */
@property (strong, nonatomic) YCLStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
