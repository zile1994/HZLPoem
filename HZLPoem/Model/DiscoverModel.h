//
//  DiscoverModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"


@interface DiscoverModel : BaseModel

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *title;

@end

@interface DiscoverItemsModel : BaseModel

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *goon;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;


@end
