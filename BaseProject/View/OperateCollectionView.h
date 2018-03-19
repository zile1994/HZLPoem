//
//  OperateCollectionView.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedButton.h"

@interface OperateCollectionView : UIView

@property (nonatomic, strong) SelectedButton *allSelectedBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *delectedBtn;

@end
