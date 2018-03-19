//
//  CollectionRhyme.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionRhyme : NSObject<NSCoding>

@property (nonatomic, strong) NSString *rhyHead;
@property (nonatomic, strong) NSString *rhyMother;
@property (nonatomic, strong) NSString *rhyContent;
- (id)initCollectionRhymeWithRhyHead:(NSString *)rhyHead rhyMother:(NSString *)rhyMother rhyContent:(NSString *)rhyContent;

@end
