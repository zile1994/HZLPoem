//
//  YunzijiModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YunzijiModel.h"

@implementation YunzijiModel

+ (NSDictionary *)objectClassInArray {
    return @{@"rows": [YunzijiRowsModel class]};
}

@end

@implementation YunzijiRowsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"typeDetail": @"TypeDetail", @"typeID": @"TypeID", @"typeImg": @"TypeImg", @"typeName": @"TypeName"};
}


@end
