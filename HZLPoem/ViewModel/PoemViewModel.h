//
//  PoemViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface PoemViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *leixing;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *xingshi;
@property (nonatomic, assign) NSInteger maxPage;
@property (nonatomic, getter=isHasMore) BOOL hasMore;

- (id)initPoemViewModelWithLeixing:(NSString *)leixing Chaodai:(NSString *)chaodai Xingshi:(NSString *)xingshi;

- (NSURL *)authorPicURLWithIndex:(NSInteger)row;
- (NSString *)authorPicStringWithIndex:(NSInteger)row;
- (NSString *)authorWithIndex:(NSInteger)row;
- (NSString *)titleWithIndex:(NSInteger)row;
- (NSString *)starWithIndex:(NSInteger)row;
- (NSString *)starCountWithIndex:(NSInteger)row;
- (NSString *)viewsWithIndex:(NSInteger)row;
- (NSString *)chaodaiWithIndex:(NSInteger)row;
- (NSString *)leixingWithIndex:(NSInteger)row;
- (NSString *)xingshiWithIndex:(NSInteger)row;
- (NSString *)yuanwenWithIndex:(NSInteger)row;
- (NSString *)viewidWithIndex:(NSInteger)row;
- (NSString *)authorIdWithIndex:(NSInteger)row;

@end
