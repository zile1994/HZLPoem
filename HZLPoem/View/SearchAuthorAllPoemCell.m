//
//  SearchAuthorAllPoemCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorAllPoemCell.h"


#define kLabelTopOffset  10
#define kChaodaiXingshiLabelFont  14
#define kTitleLabelFont  16
#define kViewStrLeixingFont  12
#define kYuanwenLabelFont  14
#define KLabelLeftOffset  15
#define kLabelLeftOffsetWithLabel  10
#define kTitleLabelWidth  self.frame.size.width * 5 / 8
#define KViewStrLexingLabelRightOffset  -20
#define kYuanwenLabelRightOffset  -20
#define kLabelCornerRadius  3


@implementation SearchAuthorAllPoemCell

- (UILabel *)xingshiLabel {
    if (!_xingshiLabel) {
        _xingshiLabel = [[UILabel alloc] init];
        _xingshiLabel.backgroundColor = kRGBColor(37, 153, 130);
        _xingshiLabel.textColor = [UIColor whiteColor];
        _xingshiLabel.layer.cornerRadius = kLabelCornerRadius;
        _xingshiLabel.layer.masksToBounds = YES;
        _xingshiLabel.font = [UIFont systemFontOfSize:kChaodaiXingshiLabelFont];
    }
    return _xingshiLabel;
}

- (UILabel *)chaodaiLabel {
    if (!_chaodaiLabel) {
        _chaodaiLabel = [[UILabel alloc] init];
        _chaodaiLabel.backgroundColor = kRGBColor(209, 155, 143);
        _chaodaiLabel.font = [UIFont systemFontOfSize:kChaodaiXingshiLabelFont];
        _chaodaiLabel.layer.cornerRadius = kLabelCornerRadius;
        _chaodaiLabel.layer.masksToBounds = YES;
        _chaodaiLabel.textColor = [UIColor whiteColor];
    }
    return _chaodaiLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldFlatFontOfSize:kTitleLabelFont];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.preferredMaxLayoutWidth = self.frame.size.width
        _titleLabel.preferredMaxLayoutWidth = 200;
    }
    return _titleLabel;
}

- (UILabel *)viewStrLeixingLabel {
    if (!_viewStrLeixingLabel) {
        _viewStrLeixingLabel = [[UILabel alloc] init];
        _viewStrLeixingLabel.font = [UIFont boldSystemFontOfSize:kViewStrLeixingFont];
        _viewStrLeixingLabel.backgroundColor = [UIColor clearColor];
        _viewStrLeixingLabel.textColor = kRGBColor(80, 80, 80);
    }
    return _viewStrLeixingLabel;
}

- (UILabel *)yuanwenLabel {
    if (!_yuanwenLabel) {
        _yuanwenLabel = [[UILabel alloc] init];
        _yuanwenLabel.numberOfLines = 2;
        _yuanwenLabel.font = [UIFont systemFontOfSize:kYuanwenLabelFont];
        _yuanwenLabel.textColor = [UIColor grayColor];
    }
    return _yuanwenLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.xingshiLabel];
        [self.contentView addSubview:self.chaodaiLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.viewStrLeixingLabel];
        [self.contentView addSubview:self.yuanwenLabel];
        [self.xingshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).with.offset(KLabelLeftOffset);
            make.top.mas_equalTo(self.contentView).with.offset(kLabelTopOffset + 2);
        }];
        [self.chaodaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.xingshiLabel.mas_right).with.offset(kLabelLeftOffsetWithLabel);
            make.top.mas_equalTo(self.contentView).with.offset(kLabelTopOffset + 2);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.chaodaiLabel.mas_right).with.offset(kLabelLeftOffsetWithLabel);
            make.top.mas_equalTo(self.contentView).with.offset(kLabelTopOffset);
            make.width.mas_equalTo(kTitleLabelWidth);
//            make.right.mas_equalTo(self.contentView).with.offset(KViewStrLexingLabelRightOffset);

        }];
        [self.viewStrLeixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).with.offset(KLabelLeftOffset);
            make.top.mas_equalTo(self.chaodaiLabel.mas_bottom).with.offset(kLabelTopOffset);
            make.right.mas_equalTo(self.contentView).with.offset(KViewStrLexingLabelRightOffset);
        }];
        [self.yuanwenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).with.offset(KLabelLeftOffset);
            make.top.mas_equalTo(self.viewStrLeixingLabel.mas_bottom).with.offset(kLabelTopOffset);
            make.right.mas_equalTo(self.contentView).with.offset(kYuanwenLabelRightOffset);
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











