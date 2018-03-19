//
//  FamousAuthorDetailModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AuthorDetailModel.h"

@implementation AuthorDetailModel

+ (NSDictionary *)objectClassInArray {
    return @{@"ziliao": [AuthorDetailZiliaoModel class]};
}

@end

@implementation AuthorDetailZiliaoModel

@end