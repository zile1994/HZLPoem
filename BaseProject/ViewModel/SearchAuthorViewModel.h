//
//  SearchAuthorViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface SearchAuthorViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, assign) NSInteger maxPage;
@property (nonatomic, getter=isHasMore) BOOL hasMore;
- (id)initSearchAuthorViewModelWithChaodai:(NSString *)chaodai;

- (NSString *)getAuthorForRow:(NSInteger)row;
- (NSString *)getAuthorIdForRow:(NSInteger)row;
- (NSString *)getChaodaiForRow:(NSInteger)row;
- (NSURL *)getIconForRow:(NSInteger)row;
- (NSString *)getIconStringForRow:(NSInteger)row;
- (NSString *)getJianjieForRow:(NSInteger)row;
- (NSString *)getLetterForRow:(NSInteger)row;
- (NSString *)getViewsFoeRow:(NSInteger)row;

@end
