//
//  ShijingModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface ShijingModel : BaseModel

@property (nonatomic, strong) NSArray *index;
@property (nonatomic, strong) NSArray *list;

@end

@interface ShijingListModel : BaseModel

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *title;

@end

@interface ShijingListItemsModel : BaseModel

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *title;

@end