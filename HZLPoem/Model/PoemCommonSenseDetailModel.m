
//
//  PoemCommonSenseDetailModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseDetailModel.h"

@implementation PoemCommonSenseDetailModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"answer": @"Answer", @"author": @"Author", @"cDate": @"CDate", @"fID": @"FID", @"question": @"Question", @"type": @"Type", @"uDate": @"UDate"};
}

@end
