//
//  FamousAuthorDetailViewModel.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DiscoverNetManager.h"

@interface AuthorDetailViewModel : BaseViewModel

@property (nonatomic, strong) NSString *authorName;
- (id)initAuthorDetailViewModelWithAuthorName:(NSString *)authorName;
@property (nonatomic, strong) NSString *authorId;
- (id)initAuthorDetailViewModelWithAuthorId:(NSString *)authorId;


@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) AuthorDetailModel  *authorDetailModel;

- (NSString *)ziliaoModelAuthorForRow:(NSInteger)row;
- (NSString *)ziliaoModelAuthoridForRow:(NSInteger)row;
- (NSString *)ziliaoModelWriteForRow:(NSInteger)row;
- (NSString *)ziliaoModelTitleForRow:(NSInteger)row;
- (NSString *)ziliaoModelZlidForRow:(NSInteger)row;

@end
