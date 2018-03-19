//
//  GelvjiModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface GelvjiModel : BaseModel

@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) NSInteger total;

@end

@interface GelvjiRowsModel : BaseModel

@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *melody;
@property (nonatomic, strong) NSString *melodyNote;
@property (nonatomic, strong) NSString *memID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameDetail;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *sample;

@end
