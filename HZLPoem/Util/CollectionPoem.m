//
//  CollectionPoem.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionPoem.h"

@implementation CollectionPoem

- (id)initCollectionPoemWithTitle:(NSString *)title Author:(NSString *)author Viewid:(NSString *)viewid {
    if (self = [super init]) {
        self.title = title;
        self.author = author;
        self.viewid = viewid;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.viewid = [aDecoder decodeObjectForKey:@"viewid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.viewid forKey:@"viewid"];
}


@end
