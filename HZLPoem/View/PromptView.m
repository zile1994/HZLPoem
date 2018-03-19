//
//  PromptView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PromptView.h"

@implementation PromptView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.promptLabel = [[UILabel alloc] init];
        self.promptLabel.textAlignment = NSTextAlignmentCenter;
        self.promptLabel.textColor = [UIColor whiteColor];
        self.promptLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
        [self addSubview:self.promptLabel];
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
