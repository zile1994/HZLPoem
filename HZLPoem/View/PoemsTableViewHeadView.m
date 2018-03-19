//
//  PoemsTableViewHeadView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemsTableViewHeadView.h"

@implementation PoemsTableViewHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.poemImageView = [[UIImageView alloc] init];
        [self addSubview:self.poemImageView];
        [self.poemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self).with.offset(10);
            make.bottom.mas_equalTo(self).with.offset(-10);
        }];
        self.jianjieLabel = [[UILabel alloc] init];
        self.jianjieLabel.backgroundColor = [UIColor clearColor];
        self.jianjieLabel.font = [UIFont boldSystemFontOfSize:15];
        self.jianjieLabel.textColor = [UIColor blackColor];
        self.jianjieLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 40;
        self.jianjieLabel.numberOfLines = 0;
        [self addSubview:self.jianjieLabel];
        [self.jianjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(20);
            make.center.mas_equalTo(self);
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
