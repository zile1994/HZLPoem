//
//  CollectionGelv.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionGelv.h"

@implementation CollectionGelv

- (id)initGelvjiDetailViewControllerWithName:(NSString *)name NameDetail:(NSString *)nameDetail Intro:(NSString *)intro Sample:(NSString *)sample MelodyNote:(NSString *)melodyNote {
    if (self = [super init]) {
        self.name = name;
        self.nameDetail = nameDetail;
        self.intro = intro;
        self.sample = sample;
        self.melodyNote = melodyNote;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nameDetail = [aDecoder decodeObjectForKey:@"nameDetail"];
        self.intro = [aDecoder decodeObjectForKey:@"intro"];
        self.sample = [aDecoder decodeObjectForKey:@"sample"];
        self.melodyNote = [aDecoder decodeObjectForKey:@"melodyNote"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nameDetail forKey:@"nameDetail"];
    [aCoder encodeObject:self.intro forKey:@"intro"];
    [aCoder encodeObject:self.sample forKey:@"sample"];
    [aCoder encodeObject:self.melodyNote forKey:@"melodyNote"];
}

@end
