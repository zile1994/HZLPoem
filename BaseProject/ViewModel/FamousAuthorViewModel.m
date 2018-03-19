//
//  FamousAuthorViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "FamousAuthorViewModel.h"

@implementation FamousAuthorViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getFamousAuthorListCompletionHandle:^(FamousAuthorModel *model, NSError *error) {
        if (!error) {
            [self.dataArr addObjectsFromArray:model.items];
            [self.titleArr addObjectsFromArray:model.titles];
        }
        completionHandle(error);
    }];
}

- (NSArray *)getAuthorArrForSection:(NSInteger)section {
    if (self.dataArr.count  == 0 || self.dataArr.count < section) {
        return NULL;
    } else {
    return self.dataArr[section];
    }
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    [self getDataFromNetCompleteHandle:completionHandle];
}

@end
