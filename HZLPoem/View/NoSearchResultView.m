//
//  NoSearchResultView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/11.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NoSearchResultView.h"

@implementation NoSearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.noResultLabel = [[UILabel alloc] init];
        self.noResultLabel.textAlignment = NSTextAlignmentCenter;
        self.noResultLabel.font = [UIFont systemFontOfSize:15];
        self.noResultLabel.numberOfLines = 0;
        self.noResultLabel.text = @"断网了哦! 下拉刷新或检查网络连接设置   >";
        self.noResultLabel.textColor = [UIColor blackColor];
        self.noResultLabel.backgroundColor = kRGBColor(227, 220, 150);
        [self addSubview:self.noResultLabel];
        [self.noResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
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
