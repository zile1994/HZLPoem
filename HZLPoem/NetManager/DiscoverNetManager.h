//
//  DiscoverNetManager.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "DiscoverModel.h"
#import "FamousAuthorModel.h"
#import "AuthorDetailModel.h"
#import "ShijingModel.h"
#import "ChuciModel.h"
#import "OtherGushiWenModel.h"
#import "SearchAuthorModel.h"
#import "SearchAuthorAllPoemModel.h"
#import "ResultOfSearchModel.h"


@interface DiscoverNetManager : BaseNetManager

/**获取发现界面*/
//http://iapi.ipadown.com/api/gushiwen/i.faxian.php
+ (id)getDiscoverListCompletionHandle:(void(^)(NSMutableArray *arr, NSError *error))completeHandle;

/**用户自己搜索*/
//http://iapi.ipadown.com/api/gushiwen/gushiwen.view.t.list.api.php?keywords=%E7%8E%8B%E5%AE%89%E7%9F%B3&p=1&pagesize=20
+ (id)getSearchResultsWithKeywords:(NSString *)keywords PageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(ResultOfSearchModel *model, NSError *error))completonHadnle;

/**获取古诗词大咖*/
//http://iapi.ipadown.com/api/gushiwen/i.famous.authors.php
+ (id)getFamousAuthorListCompletionHandle:(void(^)(FamousAuthorModel *model, NSError *error))completionHandle;

/**获取某位诗人详细信息通过名字*/
//http://iapi.ipadown.com/api/gushiwen/gushiwen.author.show.api.php?author=%E6%9D%8E%E7%99%BD
+ (id)getAuthorDetailWithAuthorName:(NSString *)authorName CompletionHandle:(void(^)(AuthorDetailModel *model, NSError *error))completionHandle;

/**获取某位诗人详细信息通过诗人Id*/
//http://iapi.ipadown.com/api/gushiwen/gushiwen.author.show.api.php?authorid=1
+ (id)getAuthorDetailWithAuthorId:(NSString *)authorId CompletionHandle:(void(^)(AuthorDetailModel *model, NSError *error))completionHandle;

/**通过朝代搜索诗人*/
//http://iapi.ipadown.com/api/gushiwen/gushiwen.author.list.api.php?chaodai=%E6%B8%85&p=1&pagesize=20
+ (id)getAuthorListWithChaodai:(NSString *)chaodai PageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(SearchAuthorModel *model, NSError *error))completionHandle;

/**获取诗经*/
//http://iapi.ipadown.com/api/gushiwen/i.shijing.php
+ (id)getShijingListCompletionHandle:(void(^)(ShijingModel *model, NSError *error))completionHandle;

/**获取楚辞*/
//http://iapi.ipadown.com/api/gushiwen/i.chuci.php
+ (id)getChuciListCompletionHandle:(void(^)(ChuciModel *model, NSError *error))completionHandle;

/**获取古文观止，乐府和课文*/
/**乐府的API示例格式*/
//http://iapi.ipadown.com/api/gushiwen/i.yuefu.php
+ (id)getOtherGushiWenWithType:(NSString *)type CompletionHandle:(void(^)(OtherGushiWenModel *model, NSError *error))completionHandle;

/**搜所某位诗人全集*/
//http://iapi.ipadown.com/api/gushiwen/gushiwen.view.list.api.php?author=%E6%9D%8E%E7%99%BD&p=1&pagesize=20
+ (id)getSearchAuthorAllPoemListWithAuthor:(NSString *)author PageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(SearchAuthorAllPoemModel *model, NSError *error))completionHandle;

@end
