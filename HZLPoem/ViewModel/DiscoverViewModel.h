//
//  DiscoverViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DiscoverNetManager.h"

@interface DiscoverViewModel : BaseViewModel

//@property (nonatomic, strong) NSMutableArray  *discoverItemArr;
@property (nonatomic, assign) NSInteger rowNumber;

- (NSString *)titleForIndex:(NSInteger)row;
- (NSArray *)getItemArrForIndex:(NSInteger)row;

@end
