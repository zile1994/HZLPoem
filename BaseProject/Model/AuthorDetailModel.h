//
//  FamousAuthorDetailModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface AuthorDetailModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *jianjie;
@property (nonatomic, strong) NSString *letter;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSArray *ziliao;

@end

@interface AuthorDetailZiliaoModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSString *writer;
@property (nonatomic, strong) NSString *zlid;

@end