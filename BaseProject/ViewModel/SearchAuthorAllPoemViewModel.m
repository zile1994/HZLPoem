//
//  SearchAuthorAllPoemViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorAllPoemViewModel.h"
#import "DiscoverNetManager.h"

@implementation SearchAuthorAllPoemViewModel

- (id)initSearchAuthorAllPoemViewModelWithAuthor:(NSString *)author {
    if (self = [super init]) {
        self.author = author;
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
    self.dataTask = [DiscoverNetManager getSearchAuthorAllPoemListWithAuthor:self.author PageIndex:self.pageIndex CompletionHandle:^(SearchAuthorAllPoemModel *model, NSError *error) {
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

- (SearchAuthorResultsAllPoemModel *)getSearchAuthorResultsAllPoenModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getAuthorForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].author;
}

- (NSString *)getChaodaiForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].chaodai;
}

- (NSString *)getXingshiForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].xingshi;
}

- (NSString *)getLeixingForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].leixing;
}

- (NSString *)getStrForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].star;
}

- (NSString *)getStrCountForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].star_count;
}

- (NSString *)getTitleForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].title;
}

- (NSString *)getViewidForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].viewid;
}

- (NSString *)getViewsForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].views;
}

- (NSString *)getYuanwenForRow:(NSInteger)row {
    return [self getSearchAuthorResultsAllPoenModelForRow:row].yuanwen;
}

@end

