//
//  FamousAuthorDetailViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AuthorDetailViewModel.h"
#import "DiscoverNetManager.h"

@implementation AuthorDetailViewModel

- (id)initAuthorDetailViewModelWithAuthorName:(NSString *)authorName {
    if (self = [super init]) {
        self.authorName = authorName;
    }
    return self;
}

- (id)initAuthorDetailViewModelWithAuthorId:(NSString *)authorId {
    if (self = [super init]) {
        self.authorId = authorId;
    }
    return self;
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    if (self.authorName) {
        self.dataTask = [DiscoverNetManager getAuthorDetailWithAuthorName:self.authorName CompletionHandle:^(AuthorDetailModel *model, NSError *error) {
            if (!(model.author.length == 0)) {
                [self.dataArr removeAllObjects];
                self.authorDetailModel = model;
                [self.dataArr addObjectsFromArray:model.ziliao];
            }
            completionHandle(error);
        }];
    }
    if (self.authorId) {
        self.dataTask = [DiscoverNetManager getAuthorDetailWithAuthorId:self.authorId CompletionHandle:^(AuthorDetailModel *model, NSError *error) {
            if (!error) {
                [self.dataArr removeAllObjects];
                self.authorDetailModel = model;
                [self.dataArr addObjectsFromArray:model.ziliao];
            }
            completionHandle(error);
        }];
    }
}

- (AuthorDetailZiliaoModel *)getDatailZiliaoModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)ziliaoModelAuthorForRow:(NSInteger)row {
    return [self getDatailZiliaoModelForRow:row].author;
}

- (NSString *)ziliaoModelAuthoridForRow:(NSInteger)row {
    return [self getDatailZiliaoModelForRow:row].authorid;
}

- (NSString *)ziliaoModelWriteForRow:(NSInteger)row {
    return [self getDatailZiliaoModelForRow:row].writer;
}

- (NSString *)ziliaoModelTitleForRow:(NSInteger)row {
    return [self getDatailZiliaoModelForRow:row].title;
}

- (NSString *)ziliaoModelZlidForRow:(NSInteger)row {
    return [self getDatailZiliaoModelForRow:row].zlid;
}

@end
