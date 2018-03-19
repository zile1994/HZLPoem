//
//  PoemDetailViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoemDetailViewController : UIViewController

@property (nonatomic, strong) NSString *viewid;
@property (nonatomic, strong) NSString *poemTitle;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *authorName;


- (id)initPoemDetailControllerWithViewid:(NSString *)viewid PoemTitle:(NSString *)poemTitle AuthorId:(NSString*)authorId AuthorName:(NSString *)authorName;
- (id)initPoemDetailControllerWithViewid:(NSString *)viewid PoemTitle:(NSString *)poemTitle AuthorName:(NSString *)authorName;

@end
