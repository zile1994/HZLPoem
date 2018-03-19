//
//  SearchAuthorAllPoemViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface SearchAuthorAllPoemViewModel : BaseViewModel

@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, getter=isHasMore) BOOL hasMore;
@property (nonatomic, assign) NSInteger maxPage;

- (id)initSearchAuthorAllPoemViewModelWithAuthor:(NSString *)author;

@property (nonatomic, assign) NSInteger rowNumber;
- (NSString *)getXingshiForRow:(NSInteger)row;
- (NSString *)getChaodaiForRow:(NSInteger)row;
- (NSString *)getTitleForRow:(NSInteger)row;
- (NSString *)getLeixingForRow:(NSInteger)row;
- (NSString *)getStrForRow:(NSInteger)row;
- (NSString *)getStrCountForRow:(NSInteger)row;
- (NSString *)getViewidForRow:(NSInteger)row;
- (NSString *)getViewsForRow:(NSInteger)row;
- (NSString *)getAuthorForRow:(NSInteger)row;
- (NSString *)getYuanwenForRow:(NSInteger)row;

@end
