//
//  ChineseRhymeModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface ChineseRhymeModel : BaseModel

@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, assign) NSInteger total;

@end

@interface ChineseRhymeRowsModel : BaseModel

@property (nonatomic, strong) NSString *rhyContent;
@property (nonatomic, strong) NSString *rhyFlag;
@property (nonatomic, strong) NSString *rhyHead;
@property (nonatomic, strong) NSString *rhyID;
@property (nonatomic, strong) NSString *rhyMother;
@property (nonatomic, strong) NSString *rhyNote;


@end
