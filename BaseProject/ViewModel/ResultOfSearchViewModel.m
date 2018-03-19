//
//  ResultOfSearchViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ResultOfSearchViewModel.h"
#import "DiscoverNetManager.h"


@implementation ResultOfSearchViewModel

- (id)initResultOfSearchViewModelWithKeyword:(NSString *)keywords {
    if (self = [super init]) {
        self.keywords = keywords;
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
    self.dataTask = [DiscoverNetManager getSearchResultsWithKeywords:self.keywords PageIndex:self.pageIndex CompletionHandle:^(ResultOfSearchModel *model, NSError *error) {
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

- (ResultOfSearchResultsModel *)getResultsOfSearchResultsModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getXingshiForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].xingshi;
}

- (NSString *)getChaodaiForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].chaodai;
}

- (NSString *)getTitleForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].title;
}

- (NSString *)getStarForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].star;
}

- (NSString *)getStarCountForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].star_count;
}

- (NSString *)getViewsForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].views;
}

- (NSString *)getLeixingForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].leixing;
}

- (NSString *)getViewIdForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].viewid;
}

- (NSString *)getYuanWenForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].yuanwen;
}

- (NSURL *)getIconForRow:(NSInteger)row {
    NSString *path = [self getResultsOfSearchResultsModelForRow:row].icon;
    return [NSURL URLWithString:path];
}

- (NSString *)getAuthorForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].author;
}

- (NSString *)getAuthorIdForRow:(NSInteger)row {
    return [self getResultsOfSearchResultsModelForRow:row].authorid;
}

@end

