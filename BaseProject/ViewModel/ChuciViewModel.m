//
//  ChuciViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChuciViewModel.h"
#import "DiscoverNetManager.h"

@implementation ChuciViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getChuciListCompletionHandle:^(ChuciModel *model, NSError *error) {
        if (!error) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:model.list];
        }
        completionHandle(error);
    }];
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (ChuciListModel *)getChuciListModelForSection:(NSInteger)section {
    if (self.dataArr.count == 0 || self.dataArr.count < section) {
        return NULL;
    } else {
        return self.dataArr[section];
    }
}

- (ChuciListItemsModel *)getChuciListItemsModelForSection:(NSInteger)section Row:(NSInteger)row {
    ChuciListModel *model = [self getChuciListModelForSection:section];
    return model.items[row];
}

- (NSInteger)numberCellsForSection:(NSInteger)section {
    return [self getChuciListModelForSection:section].items.count;
}

- (NSString *)getAuthorForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getChuciListItemsModelForSection:section Row:row].author;
}

- (NSString *)getIdForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getChuciListItemsModelForSection:section Row:row].Id;
}

- (NSString *)getTitleForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getChuciListItemsModelForSection:section Row:row].title;
}


@end
