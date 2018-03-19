//
//  ChineseRhymeModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChineseRhymeModel.h"

@implementation ChineseRhymeModel

+ (NSDictionary *)objectClassInArray {
    return @{@"rows": [ChineseRhymeRowsModel class]};
}

@end

@implementation ChineseRhymeRowsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"rhyContent": @"RhyContent", @"rhyFlag": @"RhyFlag", @"rhyHead": @"RhyHead", @"rhyID": @"RhyID", @"rhyMother": @"RhyMother", @"rhyNote": @"RhyNote"};
}

@end