//
//  ResultOfSearchViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface ResultOfSearchViewModel : BaseViewModel

@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, getter=isHasMore) BOOL hasMore;
@property (nonatomic, assign) NSInteger maxPage;
- (id)initResultOfSearchViewModelWithKeyword:(NSString *)keywords;

@property (nonatomic, assign) NSInteger rowNumber;
- (NSString *)getXingshiForRow:(NSInteger)row;
- (NSString *)getChaodaiForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getStarForRow:(NSInteger)row;
- (NSString *)getStarCountForRow:(NSInteger)row;
- (NSString *)getViewsForRow:(NSInteger)row;
- (NSString *)getLeixingForRow:(NSInteger)row;
- (NSString *)getAuthorForRow:(NSInteger)row;
- (NSString *)getViewIdForRow:(NSInteger)row;
- (NSString *)getYuanWenForRow:(NSInteger)row;
- (NSString *)getAuthorIdForRow:(NSInteger)row;
- (NSURL *)getIconForRow:(NSInteger)row;

@end
