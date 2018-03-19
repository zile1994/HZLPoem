//
//  PoemCommonSenseModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseModel.h"

@implementation PoemCommonSenseModel

+ (NSDictionary *)objectClassInArray {
    return @{@"rows": [PoemCommonSenseRowsModel class]};
}

@end

@implementation PoemCommonSenseRowsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"answer": @"Answer", @"author": @"Author", @"cDate": @"CDate", @"fID": @"FID", @"question": @"Question", @"type": @"Type", @"uDate": @"UDate"};
}

@end
