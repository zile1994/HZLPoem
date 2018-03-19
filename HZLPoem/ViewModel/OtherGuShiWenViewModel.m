//
//  OtherGuShiWenViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "OtherGuShiWenViewModel.h"
#import "DiscoverNetManager.h"

@implementation OtherGuShiWenViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (id)initOtherGuShiWenWithType:(NSString *)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getOtherGushiWenWithType:self.type CompletionHandle:^(OtherGushiWenModel *model, NSError *error) {
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

/**获取OtherGuShiWenListModel*/
- (OtherGushiWenListModel *)getOtherGuShiWenListModelForSection:(NSInteger)section {
    if (self.dataArr.count == 0 || self.dataArr.count < section) {
        return NULL;
    } else {
        return self.dataArr[section];
    }}

/**获取OtherGuShiWenListModel的title*/
- (NSString *)getOtherGuShiWenListModelTitleWithSection:(NSInteger)section {
    return [self getOtherGuShiWenListModelForSection:section].title;
}

/**获取otherGuShiWenListItemsModel*/
- (OtherGushiWenListItemsModel *)getOtherGuShiWenListItemsModelWithSection:(NSInteger)section Row:(NSInteger)row {
    OtherGushiWenListModel *model = [self getOtherGuShiWenListModelForSection:section];
    return model.items[row];
}

- (NSString *)getOtherGuShiWenListItemsModelAuthorForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getOtherGuShiWenListItemsModelWithSection:section Row:row].author;
}

- (NSString *)getOtherGuShiWenListItemsModelIdForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getOtherGuShiWenListItemsModelWithSection:section Row:row].Id;
}

- (NSString *)getOtherGuShiWenListItemsModelTitleForSection:(NSInteger)section Row:(NSInteger)row {
    return [self getOtherGuShiWenListItemsModelWithSection:section Row:row].title;
}



@end
