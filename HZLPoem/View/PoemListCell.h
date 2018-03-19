//
//  PoemListCell.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface PoemListCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *authorImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *strViewsLabel;
@property (nonatomic, strong) UILabel *formDynastyLabel;
@property (nonatomic, strong) UILabel *yuanwenLabel;

@end
