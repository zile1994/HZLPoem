//
//  SearchAuthorAllPoemModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface SearchAuthorAllPoemModel : BaseModel

@property (nonatomic, strong) NSString *nowpage;
@property (nonatomic, strong) NSString *pagesize;
@property (nonatomic, strong) NSString *resultCount;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, assign) NSInteger totalpage;

@end

@interface SearchAuthorResultsAllPoemModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *leixing;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *star_count;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewid;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSString *xingshi;
@property (nonatomic, strong) NSString *yuanwen;

@end
