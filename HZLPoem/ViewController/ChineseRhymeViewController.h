//
//  ChineseRhymeViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewController.h"
#import "MetreBaseViewController.h"

@interface ChineseRhymeViewController : MetreBaseViewController

@property (nonatomic, strong) NSString *typeID;
@property (nonatomic, strong) NSString *typeName;
- (id)initChineseRhymeViewControllerWithTypeID:(NSString *)typeID TypeName:(NSString *)typeName;

@end
