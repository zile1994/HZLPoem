//
//  OperateCollectionView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "OperateCollectionView.h"


@implementation OperateCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.allSelectedBtn = [SelectedButton buttonWithType:UIButtonTypeCustom];
        [self.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateSelected];
        self.allSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [self.allSelectedBtn setTitleColor:kRGBColor(64, 102, 150) forState:UIControlStateNormal];
        [self.allSelectedBtn setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.allSelectedBtn];
        [self.allSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 1) / 2);
        }];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.allSelectedBtn.mas_right);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(self).with.offset(7);
            make.height.mas_equalTo(30);
        }];
        
        self.delectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.delectedBtn setBackgroundColor:[UIColor clearColor]];
        [self.delectedBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.delectedBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [self.delectedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:self.delectedBtn];
        [self.delectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineView.mas_right);
            make.top.right.bottom.mas_equalTo(self);
        }];
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.frame].CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(-3, -3);
        self.layer.shadowOpacity = 0.5;
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
