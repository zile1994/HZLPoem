//
//  PoemCommonSenseModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface PoemCommonSenseModel : BaseModel

@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) NSInteger total;

@end

@interface PoemCommonSenseRowsModel : BaseModel

@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *cDate;
@property (nonatomic, strong) NSString *fID;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uDate;

@end
