//
//  AppreciatePoemViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface AppreciatePoemViewModel : BaseViewModel

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, getter=isHasMore) BOOL hasMore;
@property (nonatomic, assign) NSInteger total;

- (NSString *)getAnswerForRow:(NSInteger)row;
- (NSString *)getAuthorForRow:(NSInteger)row;
- (NSString *)getCDateForRow:(NSInteger)row;
- (NSString *)getFIDForRow:(NSInteger)row;
- (NSString *)getQuestionForRow:(NSInteger)row;
- (NSString *)getTypeForRow:(NSInteger)row;
- (NSString *)getUDateForRow:(NSInteger)row;

@end
