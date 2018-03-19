//
//  GelvjiModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GelvjiModel.h"

@implementation GelvjiModel

+ (NSDictionary *)objectClassInArray {
    return @{@"rows": [GelvjiRowsModel class]};
}

@end

@implementation GelvjiRowsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"intro": @"Intro", @"melody": @"Melody", @"melodyNote": @"MelodyNote", @"memID": @"MemID", @"name": @"Name", @"nameDetail": @"NameDetail", @"nickName": @"NickName", @"sample": @"Sample"};
}

@end
