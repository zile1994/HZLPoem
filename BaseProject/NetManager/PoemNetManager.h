//
//  PoemNetManager.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "PoemModel.h"

@interface PoemNetManager : BaseNetManager

+ (id)getPoemListWithBeginIndex:(NSInteger)pageIndex Leixing:(NSString *)leixing Chaodai:(NSString *)chaodai Xingshi:(NSString *)xingshi CompletionHandle:(void(^)(PoemListModel *model, NSError *error))completionHandle;

@end
