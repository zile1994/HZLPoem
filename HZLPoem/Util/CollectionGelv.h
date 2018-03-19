//
//  CollectionGelv.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionGelv : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameDetail;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *sample;
@property (nonatomic, strong) NSString *melodyNote;
- (id)initGelvjiDetailViewControllerWithName:(NSString *)name NameDetail:(NSString *)nameDetail Intro:(NSString *)intro Sample:(NSString *)sample MelodyNote:(NSString *)melodyNote;


@end
