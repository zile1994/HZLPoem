//
//  SearchAuthorModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorModel.h"

@implementation SearchAuthorModel

+ (NSDictionary *)objectClassInArray {
    return @{@"results": [SearchAuthorResultsModel class]};
}

@end

@implementation SearchAuthorResultsModel


@end
