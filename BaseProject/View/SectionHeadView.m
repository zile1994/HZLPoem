//
//  SectionHeadView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SectionHeadView.h"

#define kTitleLabelFont  18
#define kTitleLabelLeftOffsetWithSelf  10

@implementation SectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.font = [UIFont boldFlatFontOfSize:kTitleLabelFont];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(kTitleLabelLeftOffsetWithSelf);
            make.right.top.bottom.mas_equalTo(self);
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
