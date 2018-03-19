//
//  GelvjiViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface GelvjiViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, getter=isHasMore) BOOL hasMore;

- (NSString *)getIntroForRow:(NSInteger)row;
- (NSString *)getMelodyForRow:(NSInteger)row;
- (NSString *)getMelodyNoteForRow:(NSInteger)row;
- (NSString *)getMemIDForRow:(NSInteger)row;
- (NSString *)getNameForRow:(NSInteger)row;
- (NSString *)getNameDetailForRow:(NSInteger)row;
- (NSString *)getNickNameForRow:(NSInteger)row;
- (NSString *)getSampleForRow:(NSInteger)row;

@end
