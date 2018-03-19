//
//  OtherGushiWenModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "OtherGushiWenModel.h"

@implementation OtherGushiWenModel

+ (NSDictionary *)objectClassInArray {
    return @{@"list": [OtherGushiWenListModel class]};
}

@end

@implementation OtherGushiWenListModel

+ (NSDictionary *)objectClassInArray {
    return @{@"items": [OtherGushiWenListItemsModel class]};
}

@end

@implementation OtherGushiWenListItemsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"Id": @"id"};
}

@end