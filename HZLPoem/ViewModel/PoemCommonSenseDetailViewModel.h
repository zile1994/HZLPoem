//
//  PoemCommonSenseDetailViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface PoemCommonSenseDetailViewModel : BaseViewModel

@property (nonatomic, strong) NSString *fid;
@property (nonatomic, assign) NSInteger rowNumber;
- (id)initPoemCommonSenseDatailViewModelWithFID:(NSString *)fid;

- (NSString *)getAnswerForRow:(NSInteger)row;

@end
