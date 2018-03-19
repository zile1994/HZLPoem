//
//  NoDetailInformationCell.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NoDetailInformationCell.h"


#define kNoInformationImageViewSize  CGSizeMake(336, 127)

@implementation NoDetailInformationCell

- (UIImageView *)noInformationImageView {
    if (!_noInformationImageView) {
        _noInformationImageView = [[UIImageView alloc] init];
    }
    return _noInformationImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.noInformationImageView];
        [self.noInformationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
            make.size.mas_equalTo(kNoInformationImageViewSize);
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
