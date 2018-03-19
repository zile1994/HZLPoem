//
//  DiscoverViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DiscoverViewModel.h"
#import "DiscoverNetManager.h"

@implementation DiscoverViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getDiscoverListCompletionHandle:^(NSMutableArray *arr, NSError *error) {
      [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if (!error) {
              [self.dataArr addObject:obj];
          }
      }];
      completionHandle(error);
    }];
}

- (DiscoverModel *)discoverForIndex:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (NSString *)titleForIndex:(NSInteger)row {
    return [self discoverForIndex:row].title;
}

- (NSArray *)getItemArrForIndex:(NSInteger)row {
    return [self discoverForIndex:row].items;
}






@end
