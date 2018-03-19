//
//  PoemModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface PoemListModel : BaseModel

@property (nonatomic, assign) NSInteger nowpage;
@property (nonatomic, assign) NSInteger pagesize;
@property (nonatomic, assign) NSInteger resultCount;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalpage;

@end

@interface PoemModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSString *authorid;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *leixing;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *star_count;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *viewid;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSString *xingshi;
@property (nonatomic, strong) NSString *yuanwen;

@end
