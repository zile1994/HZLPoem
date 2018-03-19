//
//  ChineseRhymeViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChineseRhymeViewModel.h"
#import "MetreNetManager.h"

@implementation ChineseRhymeViewModel

- (id)initChineseRhymeViewModelWithTypeID:(NSString *)typeID {
    if (self = [super init]) {
        self.typeID = typeID;
    }
    return self;
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (BOOL)isHasMore {
    return (self.total / 20) > self.pageIndex;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [MetreNetManager getChineseRhyWithTypeID:self.typeID PageIndex:self.pageIndex CompletionHandle:^(ChineseRhymeModel *model, NSError *error) {
        if (!error) {
            if (self.pageIndex == 0) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:model.rows];
            self.total = model.total;
        }
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    self.pageIndex = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle {
    if (self.hasMore) {
        self.pageIndex = self.pageIndex + 1;
        [self getDataFromNetCompleteHandle:completionHandle];
    } else {
        NSError *error = [NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey: @"没有更多数据了"}];
        completionHandle(error);
    }
}

- (ChineseRhymeRowsModel *)getChineseRhymeRowsModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getRhyIDForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyID;
}

- (NSString *)getRhyFlagForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyFlag;
}

- (NSString *)getRhyHeadForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyHead;
}

- (NSString *)getRhyNoteForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyNote;
}

- (NSString *)getRhyMotherForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyMother;
}

- (NSString *)getRhyContentForRow:(NSInteger)row {
    return [self getChineseRhymeRowsModelForRow:row].rhyContent;
}

@end
