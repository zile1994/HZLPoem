//
//  YunzijiCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YunzijiCell.h"



@implementation YunzijiCell

- (UIImageView *)descImageView {
    if (!_descImageView) {
        _descImageView = [[UIImageView alloc] init];
    }
    return _descImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldFlatFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.numberOfLines = 0;
        _descLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 80 - 30;
    }
    return _descLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.descImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        [self.descImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).with.offset(10);
            make.left.mas_equalTo(self.descImageView.mas_right).with.offset(10);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.descImageView.mas_right).with.offset(10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
