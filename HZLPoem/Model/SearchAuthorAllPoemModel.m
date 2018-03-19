//
//  SearchAuthorAllPoemModel.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorAllPoemModel.h"

@implementation SearchAuthorAllPoemModel

+ (NSDictionary *)objectClassInArray {
    return @{@"results": [SearchAuthorResultsAllPoemModel class]};
}

@end

@implementation SearchAuthorResultsAllPoemModel

@end