//
//  ChineseRhymeViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChineseRhymeViewModel : BaseViewModel

@property (nonatomic, strong) NSString *typeID;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, getter=isHasMore) BOOL hasMore;
@property (nonatomic, assign) NSInteger total;
- (id)initChineseRhymeViewModelWithTypeID:(NSString *)typeID;

@property (nonatomic, assign) NSInteger rowNumber;
- (NSString *)getRhyContentForRow:(NSInteger)row;
- (NSString *)getRhyFlagForRow:(NSInteger)row;
- (NSString *)getRhyHeadForRow:(NSInteger)row;
- (NSString *)getRhyIDForRow:(NSInteger)row;
- (NSString *)getRhyMotherForRow:(NSInteger)row;
- (NSString *)getRhyNoteForRow:(NSInteger)row;

@end
