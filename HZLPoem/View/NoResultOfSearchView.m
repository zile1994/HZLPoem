//
//  NoResultOfSearchView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NoResultOfSearchView.h"

@implementation NoResultOfSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.noResultOfSearchLabel = [[UILabel alloc] init];
        self.noResultOfSearchLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:self.noResultOfSearchLabel];
        [self.noResultOfSearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        self.noResultOfSearchLabel.textAlignment = NSTextAlignmentCenter;
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
