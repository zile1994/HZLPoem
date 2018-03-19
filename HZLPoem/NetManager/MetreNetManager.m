//
//  MetreNetManager.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MetreNetManager.h"

@implementation MetreNetManager

+ (id)getYunzijiListCompletionHandle:(void (^)(YunzijiModel *, NSError *))completionHandle {
    NSString *path = @"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=rhymetypequery";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([YunzijiModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getChineseRhyWithTypeID:(NSString *)typeID PageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(ChineseRhymeModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=rhymequery&type=%@&key=&pageSize=20&pageIndex=%lu", typeID, pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ChineseRhymeModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getGelvjiWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(GelvjiModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=melodylist&pageSize=20&key=&pageIndex=%lu", pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([GelvjiModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getPoemCommonSenseWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(PoemCommonSenseModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=faqlist&pageSize=20&key=&pageIndex=%lu", pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([PoemCommonSenseModel objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getPoemCommonSenseDetailWithFID:(NSString *)fid CompletionHandle:(void (^)(NSMutableArray *, NSError *))compltionHandle {
    NSString *path = [NSString stringWithFormat:@"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=linkfaq&fid=%@", fid];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSMutableArray *arr = [NSMutableArray array];
        [responseObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PoemCommonSenseDetailModel *model = [PoemCommonSenseDetailModel objectWithKeyValues:obj];
            [arr addObject:model];
        }];
        compltionHandle(arr, error);
    }];
}

+ (id)getApprecicatePoemWithWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void (^)(PoemCommonSenseModel *, NSError *))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=articlelist&pageSize=20&key=&pageIndex=%lu", pageIndex];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([PoemCommonSenseModel objectWithKeyValues:responseObj], error);
    }];
}

@end
