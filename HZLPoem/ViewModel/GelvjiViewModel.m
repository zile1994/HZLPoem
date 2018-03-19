//
//  GelvjiViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GelvjiViewModel.h"
#import "MetreNetManager.h"

@implementation GelvjiViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (BOOL)isHasMore {
    return (self.total / 20) > self.pageIndex;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [MetreNetManager getGelvjiWithPageIndex:self.pageIndex CompletionHandle:^(GelvjiModel *model, NSError *error) {
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

- (GelvjiRowsModel *)getGelvjiRowsModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getNameForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].name;
}

- (NSString *)getIntroForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].intro;
}

- (NSString *)getMemIDForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].memID;
}

- (NSString *)getMelodyForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].melody;
}

- (NSString *)getSampleForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].sample;
}

- (NSString *)getNickNameForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].nickName;
}

- (NSString *)getNameDetailForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].nameDetail;
}

- (NSString *)getMelodyNoteForRow:(NSInteger)row {
    return [self getGelvjiRowsModelForRow:row].melodyNote;
}


@end
