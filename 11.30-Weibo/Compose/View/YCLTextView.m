//
//  YCLTextView.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/12.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLTextView.h"
#import "NSString+YCLTextSize.h"
#import "UIView+YCLGeometry.h"

@interface YCLTextView ()
/** placeHolder */
@property (weak, nonatomic) UILabel *placeholderLabel;
@end

@implementation YCLTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        // 添加 placeHolder
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor blackColor];
        placeholderLabel.text = @"Share a status...";
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 设置默认字体（因为 placeholderLabel 的字体来源于 self ）
        self.font = [UIFont systemFontOfSize:16];
        
        // 注册监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChanged) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    // 字体统一
    self.placeholderLabel.font = self.font;
}

- (void)textViewTextDidChanged {
    self.placeholderLabel.hidden = self.text.length > 0;
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize textSize = [self.placeholderLabel.text sizeWithFont:self.placeholderLabel.font
                                                       maxSize:CGSizeMake(self.frameW, MAXFLOAT)];
    self.placeholderLabel.frameX = 5;
    self.placeholderLabel.frameY = 7;
    self.placeholderLabel.frameW = textSize.width;
    self.placeholderLabel.frameH = textSize.height;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
}

@end
