//
//  SearchAuthorModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface SearchAuthorModel : BaseModel

@property (nonatomic, strong) NSString *nowpage;
@property (nonatomic, strong) NSString *pagesize;
@property (nonatomic, strong) NSString *resultCount;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, assign) NSInteger totalpage;

@end

@interface SearchAuthorResultsModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *jianjie;
@property (nonatomic, strong) NSString *letter;
@property (nonatomic, strong) NSString *views;

@end
