//
//  CollectionPoem.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionPoem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *viewid;
- (id)initCollectionPoemWithTitle:(NSString *)title Author:(NSString *)author Viewid:(NSString *)viewid;

@end
