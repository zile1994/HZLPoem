//
//  FamousAuthorDetailViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FamousAuthorDetailViewController : BaseViewController

@property (nonatomic, strong) NSString *authorName;
- (id)initAuthorDetailViewControllrtWithAuthorName:(NSString *)authorName;
@property (nonatomic, strong) NSString *authorId;
- (id)initAuthorDetailViewControllrtWithAuthorId:(NSString *)authorId AuthorName:(NSString *)authorName;

@end
