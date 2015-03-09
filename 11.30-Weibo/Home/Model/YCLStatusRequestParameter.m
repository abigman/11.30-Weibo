//
//  YCLStatusParameter.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/15.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLStatusRequestParameter.h"

@implementation YCLStatusRequestParameter
- (NSNumber *)count {
  if (!_count) {
    _count = @20;
  }
  return _count;
}
@end
