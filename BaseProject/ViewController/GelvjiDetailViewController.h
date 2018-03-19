//
//  GelvjiDetailViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetreBaseViewController.h"

@interface GelvjiDetailViewController : MetreBaseViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameDetail;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *sample;
@property (nonatomic, strong) NSString *melodyNote;
- (id)initGelvjiDetailViewControllerWithName:(NSString *)name NameDetail:(NSString *)nameDetail Intro:(NSString *)intro Sample:(NSString *)sample MelodyNote:(NSString *)melodyNote;

@end
