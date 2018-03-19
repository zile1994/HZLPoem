//
//  ChaodaiAuthorListCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChaodaiAuthorListCell.h"

#define kChaodaiLabelFont  14
#define kAuthorLabelFont  16
#define kViewLabelFont  12
#define kJianjieLabelFont  13
#define kAuthorImageViewSize  CGSizeMake(55, 80)
#define kAuthorImageViewLeftTopOffset  10
#define kLabelTopOffset  10
#define kLabelLeftOffsetWithAuthotIamgeView  10
#define kJianjieLabelRightOffset  -20
#define kAuthorLabelLeftOffsetWithChaodaiLabel  10

@implementation ChaodaiAuthorListCell

- (UIImageView *)authorImageView {
    if (!_authorImageView) {
        _authorImageView = [[UIImageView alloc] init];
    }
    return _authorImageView;
}

- (UILabel *)chaodaiLabel {
    if (!_chaodaiLabel) {
        _chaodaiLabel = [[UILabel alloc] init];
        _chaodaiLabel.backgroundColor = kRGBColor(253, 128, 42);
        _chaodaiLabel.font = [UIFont systemFontOfSize:kChaodaiLabelFont];
        _chaodaiLabel.textColor = [UIColor whiteColor];
    }
    return _chaodaiLabel;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont boldFlatFontOfSize:kAuthorLabelFont];
    }
    return _authorLabel;
}

- (UILabel *)viewsLabel {
    if (!_viewsLabel) {
        _viewsLabel = [[UILabel alloc] init];
        _viewsLabel.font = [UIFont boldFlatFontOfSize:kViewLabelFont];
        _viewsLabel.textColor = kRGBColor(70, 70, 70);
    }
    return _viewsLabel;
}

- (UILabel *)jianjieLabel {
    if (!_jianjieLabel) {
        _jianjieLabel = [[UILabel alloc] init];
        _jianjieLabel.numberOfLines = 2;
        _jianjieLabel.textColor = [UIColor grayColor];
        _jianjieLabel.font = [UIFont systemFontOfSize:kJianjieLabelFont];
    }
    return _jianjieLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.authorImageView];
        [self.contentView addSubview:self.chaodaiLabel];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.viewsLabel];
        [self.contentView addSubview:self.jianjieLabel];
        [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(kAuthorImageViewLeftTopOffset);
            make.left.mas_equalTo(self.contentView).with.offset(kAuthorImageViewLeftTopOffset);
            make.size.mas_equalTo(kAuthorImageViewSize);
        }];
        [self.chaodaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(kLabelTopOffset + 2);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(kLabelLeftOffsetWithAuthotIamgeView);
        }];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.chaodaiLabel.mas_right).with.offset(kAuthorLabelLeftOffsetWithChaodaiLabel);
            make.top.mas_equalTo(self.contentView).with.offset(kLabelTopOffset);
//            make.centerY.mas_equalTo(self.chaodaiLabel);
        }];
        [self.viewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.authorLabel.mas_bottom).with.offset(kLabelTopOffset);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(kLabelLeftOffsetWithAuthotIamgeView);
        }];
        [self.jianjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.viewsLabel.mas_bottom).with.offset(kLabelTopOffset);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(kLabelLeftOffsetWithAuthotIamgeView);
            make.right.mas_equalTo(self.contentView).with.offset(kJianjieLabelRightOffset);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
