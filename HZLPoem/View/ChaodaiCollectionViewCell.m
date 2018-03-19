//
//  ChaodaiCollectionViewCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChaodaiCollectionViewCell.h"


@implementation ChaodaiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.chaodaiLabel = [[UILabel alloc] init];
        self.chaodaiLabel.textColor = kRGBColor(107, 107, 107);
        self.chaodaiLabel.textAlignment = NSTextAlignmentCenter;
        self.chaodaiLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.chaodaiLabel];
        [self.chaodaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

@end
