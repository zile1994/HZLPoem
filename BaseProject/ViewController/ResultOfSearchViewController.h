//
//  ResultOfSearchViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface ResultOfSearchViewController : BaseViewController

@property (nonatomic, strong) NSString *keywords;
- (id)initResultOfSearchViewControllerWithKeywords:(NSString *)keywords;

@end
