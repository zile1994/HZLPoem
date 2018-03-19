//
//  PoemCommonSenseDetailViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewController.h"

@interface PoemCommonSenseDetailViewController : BaseViewController

@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *question;
- (id)initPoemCommonSenseDetailViewControllerWithFID:(NSString *)fid Question:(NSString *)question;

@end
