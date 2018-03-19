//
//  SearchAuthorViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorViewModel.h"
#import "DiscoverNetManager.h"

@implementation SearchAuthorViewModel

- (id)initSearchAuthorViewModelWithChaodai:(NSString *)chaodai {
    if (self = [super init]) {
        self.chaodai = chaodai;
    }
    return self;
}

- (BOOL)isHasMore {
    return self.maxPage > self.pageIndex;
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DiscoverNetManager getAuthorListWithChaodai:self.chaodai PageIndex:self.pageIndex CompletionHandle:^(SearchAuthorModel *model, NSError *error) {
        if (!error) {
            if (self.pageIndex == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:model.results];
            self.maxPage = model.totalpage;
        }
        completionHandle(error);
    }];
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    self.pageIndex = 1;
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

- (SearchAuthorResultsModel *)getSearchAuthorResultsModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getAuthorForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].author;
}

- (NSString *)getAuthorIdForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].authorid;
}

- (NSString *)getChaodaiForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].chaodai;
}

- (NSString *)getIconStringForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].icon;
}

- (NSURL *)getIconForRow:(NSInteger)row {
    NSString *path = [self getSearchAuthorResultsModelForRow:row].icon;
    return [NSURL URLWithString:path];
}

- (NSString *)getJianjieForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].jianjie;
}

- (NSString *)getLetterForRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].letter;
}

- (NSString *)getViewsFoeRow:(NSInteger)row {
    return [self getSearchAuthorResultsModelForRow:row].views;
}

@end



