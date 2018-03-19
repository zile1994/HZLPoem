//
//  DiscoverModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

+ (NSDictionary *)objectClassInArray {
    return @{@"items": [DiscoverItemsModel class]};
}

@end

@implementation DiscoverItemsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"goon": @"goto"};
}

@end