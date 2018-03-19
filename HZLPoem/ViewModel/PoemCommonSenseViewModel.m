//
//  PoemCommonSenseViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseViewModel.h"
#import "MetreNetManager.h"

@implementation PoemCommonSenseViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (BOOL)isHasMore {
    return (self.total / 20) > self.pageIndex;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [MetreNetManager getPoemCommonSenseWithPageIndex:self.pageIndex CompletionHandle:^(PoemCommonSenseModel *model, NSError *error) {
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

- (PoemCommonSenseRowsModel *)getPoemCommonSenseRowsModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getFIDForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].fID;
}

- (NSString *)getTypeForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].type;
}

- (NSString *)getCDateForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].cDate;
}

- (NSString *)getUDateForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].uDate;
}

- (NSString *)getAnswerForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].answer;
}

- (NSString *)getAuthorForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].author;
}

- (NSString *)getQuestionForRow:(NSInteger)row {
    return [self getPoemCommonSenseRowsModelForRow:row].question;
}

@end
