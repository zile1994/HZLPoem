//
//  YunzijiModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface YunzijiModel : BaseModel

@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) NSInteger total;

@end

@interface YunzijiRowsModel : BaseModel

@property (nonatomic, strong) NSString *typeDetail;
@property (nonatomic, strong) NSString *typeID;
@property (nonatomic, strong) NSString *typeImg;
@property (nonatomic, strong) NSString *typeName;


@end