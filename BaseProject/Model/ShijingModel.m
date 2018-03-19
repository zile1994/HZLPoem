//
//  ShijingModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShijingModel.h"

@implementation ShijingModel

+ (NSDictionary *)objectClassInArray {
    return @{@"list": [ShijingListModel class]};
}


@end


@implementation ShijingListModel

+ (NSDictionary *)objectClassInArray {
    return @{@"items": [ShijingListItemsModel class]};
}

@end


@implementation ShijingListItemsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"Id": @"id"};
}

@end