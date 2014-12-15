//
//  Foundation+Log.m
//  12.03-Test
//
//  Created by Chenglin Yu on 14/12/14.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//
//  该扩展用于输出词典、数组的时候显示中文

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *descriptionString = [NSMutableString string];
    [descriptionString appendString:@"字典开始 -> {\n"];
    
    // 便利字典的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [descriptionString appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [descriptionString appendString:@"\n} <- 字典结束"];
    
    // 查找最后一个, 的范围 [从后往前，第一个]
    NSRange range = [descriptionString rangeOfString:@",\n" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [descriptionString deleteCharactersInRange:range];
    }
    return descriptionString;
}
@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {

    NSMutableString *descriptionString = [NSMutableString string];
    [descriptionString appendString:@"数组开始 ->[\n"];
    
    // 便利数组的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [descriptionString appendFormat:@"\t%@,\n", obj];
    }];
    [descriptionString appendString:@"\n]<- 数组结束"];
    
    // 查找最后一个, 的范围 [从后往前，第一个]
    NSRange range = [descriptionString rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [descriptionString deleteCharactersInRange:range];
    }
    return descriptionString;
}

@end
