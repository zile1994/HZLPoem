//
//  ChineseRhymeDetailViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetreBaseViewController.h"

@interface ChineseRhymeDetailViewController : MetreBaseViewController

@property (nonatomic, strong) NSString *rhyContent;
@property (nonatomic, strong) NSString *rhyMother;
@property (nonatomic, strong) NSString *rhyHead;
- (id)initChineseRhymeDetailViewControllerWithRhyHead:(NSString *)rhyHead rhyMother:(NSString *)rhyMother RhyContent:(NSString *)rhyContent;

@end
