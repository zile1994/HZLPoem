//
//  FamousAuthorDetailHeadView.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "FamousAuthorDetailHeadView.h"


#define kJianjieLabelFont  14
#define kAuthorLabelFont  16
#define kAuthorImageViewTopLeftOffset  15
#define kAuthorImageWidth  75
#define kAuthorImageHeight  110
#define kJianjieLabelOffSetWithAuthorImageView  15
#define kJianjieLabelTopOffset  15
#define kJIanjieLabelRightOffset  -15
#define kAuthorLabelTopOffsetWithAuthorImageView  15


@implementation FamousAuthorDetailHeadView

- (UIImageView *)authorImageView {
    if (!_authorImageView) {
        _authorImageView = [[UIImageView alloc] init];
    }
    return _authorImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:kAuthorLabelFont];
        _authorLabel.textColor = [UIColor blackColor];
        _authorLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _authorLabel;
}

- (UILabel *)jianjieLabel {
    if (!_jianjieLabel) {
        _jianjieLabel = [[UILabel alloc] init];
        _jianjieLabel.font = [UIFont systemFontOfSize:kJianjieLabelFont];
        _jianjieLabel.textColor = [UIColor grayColor];
        _jianjieLabel.numberOfLines = 0;
    }
    return _jianjieLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.authorImageView];
        [self addSubview:self.authorLabel];
        [self addSubview:self.jianjieLabel];
        [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).with.offset(kAuthorImageViewTopLeftOffset);
            make.left.mas_equalTo(self).with.offset(kAuthorImageViewTopLeftOffset);
            make.size.mas_equalTo(CGSizeMake(kAuthorImageWidth, kAuthorImageHeight));
        }];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.authorImageView);
            make.top.mas_equalTo(self.authorImageView.mas_bottom).with.offset(kAuthorLabelTopOffsetWithAuthorImageView);
        }];
        [self.jianjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(kJianjieLabelOffSetWithAuthorImageView);
            make.top.mas_equalTo(self).with.offset(kJianjieLabelTopOffset);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 130);
        }];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {

    CGFloat labelConstraintWidth = [UIScreen mainScreen].bounds.size.width - 130;
    NSString *content = self.jianjieLabel.text;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(labelConstraintWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kJianjieLabelFont]} context:nil];
    CGFloat labelHeight = rect.size.height;
    CGFloat imageHeight = 150;
    CGFloat maxHeight = MAX(labelHeight + 30, imageHeight + 40);
    CGSize sizeFit = CGSizeMake(self.frame.size.width, maxHeight );
    return sizeFit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
