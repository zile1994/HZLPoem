//
//  FamousAuthorViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DiscoverNetManager.h"


@interface FamousAuthorViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableArray *titleArr;
- (NSArray *)getAuthorArrForSection:(NSInteger)section;
@end
