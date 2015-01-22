//
//  YCLStatus.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatus.h"
#import "YCLUser.h"
#import "MJExtension.h"
#import "YCLPicture.h"

@implementation YCLStatus
//+ (instancetype)statusWithDictionary:(NSDictionary *)dict {
//    YCLStatus *status = [[self alloc] init];
//    status.text = dict[@"text"];
//    
//    // 遇到字典需要处理
//    status.user = [YCLUser userWithDictionary:dict[@"user"]];
//    
//    NSDictionary *retweetedStatusDict = dict[@"retweeted_status"];
//    if (retweetedStatusDict) {
//        status.retweeted_status = [self statusWithDictionary:retweetedStatusDict];
//    }
//    
//    
//    return status;
//}

/**
 *    通知框架 pic_ids 属性保存的是 YCLPicture 类型的对象
 */
- (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [YCLPicture class]};
}

- (NSString *)created_at {
    // 微博创建日期: 时间标签的尺寸需要获取 _created_at 来计算，所以应该在 getter 中设置
    //  _created_at 原始格式： Thu Dec 18 00:10:57 +0800 2014
    // _created_at(NSString) -> NSDate -> NSString
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEE MM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [dateFormatter dateFromString:_created_at];

    NSString *createDateFormatted = nil;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取微博创建日期的元素
    NSDateComponents *createDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:createDate];
    // 获取当前日期的元素
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];

    if (createDateComponents.year == currentDateComponents.year) {
        // 说明是今年
        if (createDateComponents.month == currentDateComponents.month && createDateComponents.day == currentDateComponents.day) {
            // 说明是今天(同年同月同日)

            if ((currentDateComponents.hour - createDateComponents.hour > 1) || (currentDateComponents.hour - createDateComponents.hour == 1 && currentDateComponents.minute >= createDateComponents.minute)) {
                // 说明是至少一个小时前
                createDateFormatted = [NSString stringWithFormat:@"%ld小时前 ", currentDateComponents.hour - createDateComponents.hour];
                dateFormatter.dateFormat = @"HH:mm:ss";
                createDateFormatted = [createDateFormatted stringByAppendingString:[dateFormatter stringFromDate:createDate]];
            } else if ((currentDateComponents.hour - createDateComponents.hour == 1 && currentDateComponents.minute < createDateComponents.minute) || (currentDateComponents.minute - createDateComponents.minute > 1) || (currentDateComponents.minute - createDateComponents.minute == 1 && currentDateComponents.second >= createDateComponents.second)) {
                // 说明是至少一分钟前
                long deltaMinute = currentDateComponents.minute - createDateComponents.minute;
                if (currentDateComponents.hour - createDateComponents.hour == 1 && currentDateComponents.minute < createDateComponents.minute) {
                    deltaMinute += 60;
                }
                createDateFormatted = [NSString stringWithFormat:@"%ld分钟前 ", deltaMinute];
                dateFormatter.dateFormat = @"HH:mm:ss";
                createDateFormatted = [createDateFormatted stringByAppendingString:[dateFormatter stringFromDate:createDate]];
            } else {
                // 说明是一分钟內
                createDateFormatted = @"刚刚 ";
                dateFormatter.dateFormat = @"HH:mm:ss";
                createDateFormatted = [createDateFormatted stringByAppendingString:[dateFormatter stringFromDate:createDate]];
            }
        } else {
            // 说明不是今天
            if (createDateComponents.month == currentDateComponents.month && currentDateComponents.day - createDateComponents.day == 1) {
                // 昨天（）
                dateFormatter.dateFormat = @"昨天 HH:mm";
                createDateFormatted = [dateFormatter stringFromDate:createDate];
            } else {
                // 前天或者更久
                dateFormatter.dateFormat = @"MM-dd HH:mm";
                createDateFormatted = [dateFormatter stringFromDate:createDate];
            }
        }
    } else {
        // 非今年
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        createDateFormatted = [dateFormatter stringFromDate:createDate] ;
    }

    
    return createDateFormatted;
}

- (void)setSource:(NSString *)source {
    // 微博来源可能为空
    if (source.length > 0) {
        NSRange range1 = [source rangeOfString:@">"];
        NSRange range2 = [source rangeOfString:@"</"];
        NSRange range3 = NSMakeRange(range1.location + 1, range2.location - 1 - range1.location);
        NSString *sourceString = [source substringWithRange:range3];
        sourceString = [NSString stringWithFormat:@"来自%@", sourceString];
        //    NSLog(@"%@", sourceString);
        _source = sourceString;
    }
}

@end
