
//
//  PoemCommonSenseDetailViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseDetailViewModel.h"
#import "MetreNetManager.h"

@implementation PoemCommonSenseDetailViewModel

- (id)initPoemCommonSenseDatailViewModelWithFID:(NSString *)fid {
    if (self = [super init]) {
        self.fid = fid;
    }
    return self;
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [MetreNetManager getPoemCommonSenseDetailWithFID:self.fid CompletionHandle:^(NSMutableArray *arr, NSError *error) {
        if (!error) {
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dataArr addObject:obj];
            }];
        }
        completionHandle(error);
    }];
}

- (PoemCommonSenseDetailModel *)getPoemCommonSenseDetailViewModelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

- (NSString *)getAnswerForRow:(NSInteger)row {
    return [self getPoemCommonSenseDetailViewModelForRow:row].answer;
}

@end
