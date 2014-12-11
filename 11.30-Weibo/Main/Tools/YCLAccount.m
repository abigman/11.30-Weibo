//
//  YCLAccount.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/11.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLAccount.h"

@implementation YCLAccount

/**
 *    怎么解码
 *
 *    @param aDecoder 解析器
 *
 *    @return 解析后的对象
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

/**
 *    怎么编码
 *
 *    @param aCoder 编码器
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
//        // 字典的 key 比 属性多，不能用次方法一次性赋值
//        [self setValuesForKeysWithDictionary:dict];
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
    }
    return self;
}

+ (instancetype)accountWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

+ (instancetype)account {
    return [[self alloc] init];
}
@end
