//
//  OtherGuShiWenViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OtherGuShiWenViewController : BaseViewController

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *titleName;
- (id)initOtherGuShiWenViewControllerWithType:(NSString *)type TitleName:(NSString *)titleName;

@end
