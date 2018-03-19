//
//  CollectionRhyme.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionRhyme.h"

@implementation CollectionRhyme

- (id)initCollectionRhymeWithRhyHead:(NSString *)rhyHead rhyMother:(NSString *)rhyMother rhyContent:(NSString *)rhyContent {
    if (self = [super init]) {
        self.rhyHead = rhyHead;
        self.rhyMother = rhyMother;
        self.rhyContent = rhyContent;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.rhyHead = [aDecoder decodeObjectForKey:@"rhyHead"];
        self.rhyMother = [aDecoder decodeObjectForKey:@"rhyMother"];
        self.rhyContent = [aDecoder decodeObjectForKey:@"rhyContent"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.rhyHead forKey:@"rhyHead"];
    [aCoder encodeObject:self.rhyMother forKey:@"rhyMother"];
    [aCoder encodeObject:self.rhyContent forKey:@"rhyContent"];
}

@end
