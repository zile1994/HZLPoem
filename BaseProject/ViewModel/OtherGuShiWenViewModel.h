//
//  OtherGuShiWenViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "OtherGushiWenModel.h"

@interface OtherGuShiWenViewModel : BaseViewModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) OtherGushiWenListModel *otherGuShiWenListModel;
@property (nonatomic, assign) NSInteger rowNumber;

- (id)initOtherGuShiWenWithType:(NSString *)type;

- (OtherGushiWenListModel *)getOtherGuShiWenListModelForSection:(NSInteger)section;
- (NSString *)getOtherGuShiWenListModelTitleWithSection:(NSInteger)section;
- (NSString *)getOtherGuShiWenListItemsModelAuthorForSection:(NSInteger)section Row:(NSInteger)row;
- (NSString *)getOtherGuShiWenListItemsModelIdForSection:(NSInteger)section Row:(NSInteger)row;
- (NSString *)getOtherGuShiWenListItemsModelTitleForSection:(NSInteger)section Row:(NSInteger)row;

@end
