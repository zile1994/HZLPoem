//
//  PoemViewModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemViewModel.h"
#import "PoemNetManager.h"

@implementation PoemViewModel

- (id)initPoemViewModelWithLeixing:(NSString *)leixing Chaodai:(NSString *)chaodai Xingshi:(NSString *)xingshi {
    if (self = [super init]) {
        self.leixing = leixing;
        self.chaodai = chaodai;
        self.xingshi = xingshi;
    }
    return self;
}

/**建立网络任务，调用发送请求block函数，并将json数据转化为字典数组*/
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [PoemNetManager getPoemListWithBeginIndex:self.index Leixing:self.leixing Chaodai:self.chaodai Xingshi:self.xingshi CompletionHandle:^(PoemListModel *model, NSError *error) {
        if (!error) {
            if (self.index == 1) {
                [self.dataArr removeAllObjects];
            }
            [self.dataArr addObjectsFromArray:model.results];
            self.maxPage = model.totalpage;
        }
        completionHandle(error);
    }];
}

/**将数组中的字典转化为诗文模型*/
- (PoemModel *)modelForRow:(NSInteger)row {
    if (self.dataArr.count == 0 || self.dataArr.count < row) {
        return NULL;
    } else {
        return self.dataArr[row];
    }
}

/**从模型中获取诗文标题、作者id、作者等详细数据*/
- (NSString *)authorIdWithIndex:(NSInteger)row {
    return [self modelForRow:row].authorid;
}

- (NSString *)authorWithIndex:(NSInteger)row {
    return [self modelForRow:row].author;
}

- (NSString *)titleWithIndex:(NSInteger)row {
    return [self modelForRow:row].title;
}

- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle {
    if (self.hasMore) {
        self.index = self.index + 1;
        [self getDataFromNetCompleteHandle:completionHandle];
    } else {
        NSError *error = [NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey: @"没有更多数据了"}];
        completionHandle(error);
    }
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    self.index = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}


- (BOOL)isHasMore {
    return self.maxPage > self.index;
}

- (NSInteger)rowNumber {
    return self.dataArr.count;
}

- (NSURL *)authorPicURLWithIndex:(NSInteger)row {
    NSString *path = [self modelForRow:row].icon;
    return [NSURL URLWithString:path];
}

- (NSString *)authorPicStringWithIndex:(NSInteger)row {
    return [self modelForRow:row].icon;
}

- (NSString *)viewsWithIndex:(NSInteger)row {
    return [self modelForRow:row].views;
}

- (NSString *)viewidWithIndex:(NSInteger)row {
    return [self modelForRow:row].viewid;
}

- (NSString *)chaodaiWithIndex:(NSInteger)row {
    return [self modelForRow:row].chaodai;
}

- (NSString *)leixingWithIndex:(NSInteger)row {
    return [self modelForRow:row].leixing;
}

- (NSString *)xingshiWithIndex:(NSInteger)row {
    return [self modelForRow:row].xingshi;
}

- (NSString *)yuanwenWithIndex:(NSInteger)row {
    return [self modelForRow:row].yuanwen;
}

- (NSString *)starCountWithIndex:(NSInteger)row {
    return [self modelForRow:row].star_count;
}

- (NSString *)starWithIndex:(NSInteger)row {
    return [self modelForRow:row].star;
}




@end
