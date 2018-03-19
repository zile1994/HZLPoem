//
//  NoCollectionView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NoCollectionView.h"

@implementation NoCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.noCollectionImageView = [[UIImageView alloc] init];
        [self addSubview:self.noCollectionImageView];
        [self.noCollectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
