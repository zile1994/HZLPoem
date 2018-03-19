//
//  ShijingViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "ShijingModel.h"

@interface ShijingViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;

- (ShijingListModel *)getShijingListModelForSection:(NSInteger)section;
- (NSString *)getSectiontitleForSection:(NSInteger)section;
- (NSString *)getIdForSection:(NSInteger)section Row:(NSInteger)row;
- (NSString *)getTitleForSection:(NSInteger)section Row:(NSInteger)row;

@end
