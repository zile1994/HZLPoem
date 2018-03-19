//
//  PoemNetManager.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemNetManager.h"

@implementation PoemNetManager

/**网络请求代码*/
+ (id)getPoemListWithBeginIndex:(NSInteger)pageIndex Leixing:(NSString *)leixing Chaodai:(NSString *)chaodai Xingshi:(NSString *)xingshi CompletionHandle:(void (^)(PoemListModel *, NSError *))completionHandle {
    /**将中文转化为UTF8编码，服务器不识别中文*/
    NSString *leixingUTF8 = [leixing stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *chaodaiUTF8 = [chaodai stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *xingshiUTF8 = [xingshi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.view.t.list.api.php?p=%lu&pagesize=20&leixing=%@&chaodai=%@&xingshi=%@", pageIndex, leixingUTF8, chaodaiUTF8, xingshiUTF8];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([PoemListModel objectWithKeyValues:responseObj],error);
    }];
}

@end
