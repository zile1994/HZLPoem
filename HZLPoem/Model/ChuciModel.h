//
//  ChuciModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface ChuciModel : BaseModel

@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, strong) NSArray *list;

@end


@interface ChuciListModel : BaseModel

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *title;

@end

@interface ChuciListItemsModel : BaseModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *title;

@end