//
//  ChuciViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "ChuciModel.h"

@interface ChuciViewModel : BaseViewModel

@property (nonatomic, strong) ChuciListModel *chucilistModel;
@property (nonatomic, assign) NSInteger rowNumber;

- (NSInteger)numberCellsForSection:(NSInteger)section;
- (NSString *)getAuthorForSection:(NSInteger)section Row:(NSInteger)row;
- (NSString *)getIdForSection:(NSInteger)section Row:(NSInteger)row;
- (NSString *)getTitleForSection:(NSInteger)section Row:(NSInteger)row;

@end
