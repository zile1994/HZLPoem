//
//  PoemListCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemListCell.h"

#define kAuthorLabelFont  15
#define kTitleLabelFont  16
#define kStrViewLabelFont  13
#define kFormDanastyLabelFont  14
#define kYuanwenLabelFont  15
#define kAuthorImageLeftTopOffset  10
#define kAuthorImageSize  CGSizeMake(60, 90)
#define kLabelLeftTopOffset  5
#define kTitleLabelLeftOffsetWithAuthorLabel  10
#define kYuanwenLabelRightOffset  -5
#define KTitleLabelRightOffset  -10
#define kFormDanastRightOffset  -10


@implementation PoemListCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)authorImageView {
    if (!_authorImageView) {
        _authorImageView = [[UIImageView alloc] init];
    }
    return _authorImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [self setLabelWithFont:kAuthorLabelFont BackgroundColor:kRGBColor(253, 147, 66) textColor:[UIColor whiteColor]];
        _authorLabel.layer.cornerRadius = 3;
        _authorLabel.layer.masksToBounds = YES;
    }
    return _authorLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self setLabelWithFont:kTitleLabelFont BackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

- (UILabel *)strViewsLabel {
    if (!_strViewsLabel) {
        _strViewsLabel = [self setLabelWithFont:kStrViewLabelFont BackgroundColor:[UIColor clearColor] textColor:kRGBColor(100, 100, 100)];
    }
    return _strViewsLabel;
}

- (UILabel *)formDynastyLabel {
    if (!_formDynastyLabel) {
        _formDynastyLabel = [self setLabelWithFont:kFormDanastyLabelFont BackgroundColor:[UIColor clearColor] textColor:kRGBColor(100, 100, 100)];
    }
    return _formDynastyLabel;
}

- (UILabel *)yuanwenLabel {
    if (!_yuanwenLabel) {
        _yuanwenLabel = [self setLabelWithFont:kYuanwenLabelFont BackgroundColor:[UIColor clearColor] textColor:kRGBColor(124, 124, 124)];
    }
    return _yuanwenLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.authorImageView];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.strViewsLabel];
        [self.contentView addSubview:self.formDynastyLabel];
        [self.contentView addSubview:self.yuanwenLabel];
        [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
            make.size.mas_equalTo(kAuthorImageSize);
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        }];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(7);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.authorLabel);
            make.left.mas_equalTo(self.authorLabel.mas_right).with.offset(10);
        }];
        [self.strViewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.authorLabel.mas_bottom).with.offset(5);
        }];
        [self.formDynastyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.strViewsLabel.mas_bottom).with.offset(5);
            make.right.mas_equalTo(self.contentView).with.offset(kFormDanastRightOffset);
        }];
        [self.yuanwenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.formDynastyLabel.mas_bottom).with.offset(5);
            make.right.mas_equalTo(self.contentView).with.offset(kYuanwenLabelRightOffset);
        }];
    }
    return self;
}

- (UILabel *)setLabelWithFont:(NSInteger)font BackgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.font = [UIFont boldSystemFontOfSize:font];
    label.textColor = textColor;
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
