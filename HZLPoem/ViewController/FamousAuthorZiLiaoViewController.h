//
//  FamousAuthorZiLiaoViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamousAuthorZiLiaoViewController : UIViewController

@property (nonatomic, strong) NSString *zlid;
@property (nonatomic, strong) NSString *ziliaoTitle;
- (id)initFamousAuthorZilLiaoViewControllerWithZlid:(NSString *)zlid ziliaoTitlt:(NSString *)ziliaoTitle;

@end
