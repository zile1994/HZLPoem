//
//  SearchAuthorAllPoemListViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchAuthorAllPoemListViewController : BaseViewController

@property (nonatomic, strong) NSString *authorName;
- (id)initSearchAuthorAllPoemListViewControllerWithAuthorName:(NSString *)authorName;

@end
