//
//  YunzijiViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface YunzijiViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;

- (NSString *)getTypeDetailForRow:(NSInteger)row;
- (NSString *)getTypeIDForRow:(NSInteger)row;
- (NSString *)getTypeImgForRow:(NSInteger)row;
- (NSString *)getTypeNameForRow:(NSInteger)row;

@end
