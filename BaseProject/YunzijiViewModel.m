//
//  YunzijiViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YunzijiViewModel.h"
#import "MetreNetManager.h"

@implementation YunzijiViewModel

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [MetreNetManager getYunzijiListCompletionHandle:^(YunzijiModel *model, NSError *error) {
        if (!error) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:model.rows];
        }
        completionHandle(error);
    }];
}

- (YunzijiRowsModel *)getYunzijiRowModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getTypeDetailForRow:(NSInteger)row {
    return [self getYunzijiRowModelForRow:row].typeDetail;
}

- (NSString *)getTypeImgForRow:(NSInteger)row {
    return [self getYunzijiRowModelForRow:row].typeImg;
}

- (NSString *)getTypeIDForRow:(NSInteger)row {
    return [self getYunzijiRowModelForRow:row].typeID;
}

- (NSString *)getTypeNameForRow:(NSInteger)row {
    return [self getYunzijiRowModelForRow:row].typeName;
}

@end
