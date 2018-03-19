//
//  ShijingViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShijingViewModel.h"
#import "DiscoverNetManager.h"

@implementation ShijingViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getShijingListCompletionHandle:^(ShijingModel *model, NSError *error) {
        if (!error) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:model.list];
        }
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (ShijingListModel *)getShijingListModelForSection:(NSInteger)section {
    if (self.dataArr.count == 0 || self.dataArr.count < section) {
        return NULL;
    } else {
        return self.dataArr[section];
    }
}

- (NSString *)getSectiontitleForSection:(NSInteger)section {
    return [self getShijingListModelForSection:section].title;
}

- (ShijingListItemsModel *)getShijingListItemsModelForSection:(NSInteger)section  Row:(NSInteger)row {
    ShijingListModel *model = [self getShijingListModelForSection:section];
    return model.items[row];
}

- (NSString *)getIdForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getShijingListItemsModelForSection:section Row:row].Id;
}

- (NSString *)getTitleForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getShijingListItemsModelForSection:section Row:row].title;
}



@end
