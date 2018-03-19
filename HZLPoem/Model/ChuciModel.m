//
//  ChuciModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChuciModel.h"

@implementation ChuciModel

+ (NSDictionary *)objectClassInArray {
    return @{@"list": [ChuciListModel class]};
}

@end

@implementation ChuciListModel

+ (NSDictionary *)objectClassInArray {
    return @{@"items": [ChuciListItemsModel class]};
}

@end

@implementation ChuciListItemsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"Id": @"id"};
}

@end