//
//  DiscoverCellTableViewCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DiscoverCell.h"

#define kTitleLabelFont  16
#define kDescLabelFont  14
#define kAuthorImageViewTopOffset  5
#define kAuthorImageViewLeftOffset  10
#define kAuthorImageViewWidth  50
#define kLabelLeftOffsetWithAuthorImageView  10
#define kLabelTopOffset  10


@implementation DiscoverCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)authorImageView {
    if (!_authorImageView) {
        _authorImageView = [[UIImageView alloc] init];
        _authorImageView.layer.cornerRadius = kAuthorImageViewWidth / 2;
        _authorImageView.layer.masksToBounds = YES;
    }
    return _authorImageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont systemFontOfSize:kTitleLabelFont];
    }
    return _titleLable;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor lightGrayColor];
        _descLabel.font = [UIFont systemFontOfSize:kDescLabelFont];
//        _descLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 100;
    }
    return _descLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.authorImageView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.descLabel];
        [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(5);
            make.left.mas_equalTo(self.contentView).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(kAuthorImageViewWidth, kAuthorImageViewWidth));
        }];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(10);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLable.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.authorImageView.mas_right).with.offset(10);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width  - 100);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
