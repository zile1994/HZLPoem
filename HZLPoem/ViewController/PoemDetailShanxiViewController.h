//
//  PoemDetailShanxiViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/5/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoemDetailShanxiViewController : UIViewController

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSString *poemTitle;
- (id)initPoemDetailShanxiViewControllerWithRequest:(NSURLRequest *)request poemTitle:(NSString *)poemTitle;

@end
