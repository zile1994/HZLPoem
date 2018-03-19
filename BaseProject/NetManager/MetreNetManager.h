//
//  MetreNetManager.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "YunzijiModel.h"
#import "ChineseRhymeModel.h"
#import "GelvjiModel.h"
#import "PoemCommonSenseModel.h"
#import "PoemCommonSenseDetailModel.h"

@interface MetreNetManager : BaseNetManager

/**获取韵字集*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=rhymetypequery
+ (id)getYunzijiListCompletionHandle:(void(^)(YunzijiModel *model, NSError *error))completionHandle;

/**获取中华新韵*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=rhymequery&type=1&key=&pageSize=20&pageIndex=0
+ (id)getChineseRhyWithTypeID:(NSString *)typeID PageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(ChineseRhymeModel *model, NSError *error))completionHandle;

/**获取格律集*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=melodylist&pageSize=20&key=&pageIndex=0
+ (id)getGelvjiWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(GelvjiModel *model, NSError *error))completionHandle;

/**获取诗词常识*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=faqlist&pageSize=20&key=&pageIndex=0
+ (id)getPoemCommonSenseWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(PoemCommonSenseModel *model, NSError *error))completionHandle;

/**获取诗词常识详情*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=linkfaq&fid=1
+ (id)getPoemCommonSenseDetailWithFID:(NSString *)fid CompletionHandle:(void(^)(NSMutableArray *arr, NSError *error))compltionHandle;

/**获取如何欣赏诗词*/
//http://www.wongsimon.com:8888/ipoem/poemhandler?lcode=zh-Hans-CN&version=2.0&method=articlelist&pageSize=20&key=&pageIndex=0
+ (id)getApprecicatePoemWithWithPageIndex:(NSInteger)pageIndex CompletionHandle:(void(^)(PoemCommonSenseModel *model, NSError *error))completionHandle;


@end
