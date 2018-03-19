//
//  YunzijiCell.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedButton.h"
#import "BaseTableViewCell.h"

@interface YunzijiCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *descImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end
