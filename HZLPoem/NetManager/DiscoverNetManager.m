//
//  DiscoverNetManager.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DiscoverNetManager.h"

@implementation DiscoverNetManager

+ (id)getDiscoverListCompletionHandle:(void (^)(NSMutableArray *, NSError *))completeHandle {
    NSString *path = @"http://iapi.ipadown.com/api/gushiwen/i.faxian.php";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSMutableArray *arr = [NSMutableArray array];
        [responseObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           DiscoverModel *model = [DiscoverModel objectWithKeyValues:obj];
            [arr addObject:model];
        }];
        completeHandle(arr, error);
    }];
}

+ (id)getSearchResultsWithKeywords:(NSString *)keywords PageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(ResultOfSearchModel *, NSError *))completonHadnle {
    NSString *keywordsUTF8 = [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.view.t.list.api.php?keywords=%@&p=%lu&pagesize=20", keywordsUTF8, pageIndex];
    return  [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completonHadnle([ResultOfSearchModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getFamousAuthorListCompletionHandle:(void (^)(FamousAuthorModel *, NSError *))completionHandle {
    NSString *path = @"http://iapi.ipadown.com/api/gushiwen/i.famous.authors.php";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([FamousAuthorModel objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getAuthorDetailWithAuthorName:(NSString *)authorName CompletionHandle:(void (^)(AuthorDetailModel *, NSError *))completionHandle {
    NSString *key = [authorName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.author.show.api.php?author=%@", key];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([AuthorDetailModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getAuthorDetailWithAuthorId:(NSString *)authorId CompletionHandle:(void (^)(AuthorDetailModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.author.show.api.php?authorid=%@", authorId];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([AuthorDetailModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getAuthorListWithChaodai:(NSString *)chaodai PageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(SearchAuthorModel *, NSError *))completionHandle {
    NSString *chaodaiUTF8 = [chaodai stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.author.list.api.php?chaodai=%@&p=%lu&pagesize=20", chaodaiUTF8, pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([SearchAuthorModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getShijingListCompletionHandle:(void (^)(ShijingModel *, NSError *))completionHandle {
    NSString *path = @"http://iapi.ipadown.com/api/gushiwen/i.shijing.php";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ShijingModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getChuciListCompletionHandle:(void (^)(ChuciModel *, NSError *))completionHandle {
    NSString *path = @"http://iapi.ipadown.com/api/gushiwen/i.chuci.php";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ChuciModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getOtherGushiWenWithType:(NSString *)type CompletionHandle:(void (^)(OtherGushiWenModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/i.%@.php", type];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([OtherGushiWenModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getSearchAuthorAllPoemListWithAuthor:(NSString *)author PageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(SearchAuthorAllPoemModel *, NSError *))completionHandle {
    NSString *authorUTF8 = [author stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.view.list.api.php?author=%@&p=%lu&pagesize=20", authorUTF8, pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([SearchAuthorAllPoemModel objectWithKeyValues:responseObj], error);
    }];
}

@end


