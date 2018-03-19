//
//  PoemTabBarController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemTabBarController.h"
#import "PoemListViewController.h"
#import "DiscoverViewController.h"
#import "SetupViewController.h"
#import "CollectionPoemViewController.h"
#import "CollectionAuthorViewController.h"
#import "MetreViewController.h"

extern NSString * const ToCollectionPoemViewController;
extern NSString * const ToCollectionAuthorViewController;
extern NSString * const ToSearchPoemSearchBar;
extern NSString * const TOFamousAuthorViewController;
NSString * const GoToCollectionPoemViewController = @"GoToCollectionPoemViewController";
NSString * const GoToCollectionAuthotViewController = @"GoToCollectionAuthotViewController";
NSString * const GoToSearchPoemSearchBar = @"GoToSearchPoemSearchBar";
NSString * const GoToFamousAuthorViewController = @"GoToFamousAuthorViewController";

@interface PoemTabBarController ()

@end

@implementation PoemTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    PoemListViewController *poemListVC = [[PoemListViewController alloc] init];
    UINavigationController *poemListNavi = [[UINavigationController alloc] initWithRootViewController:poemListVC];
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1];
    poemListVC.tabBarItem = firstItem;
    
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    UINavigationController *discoverNavi = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
    discoverVC.tabBarItem = secondItem;
    
    SetupViewController *setupVC = [[SetupViewController alloc] init];
    UINavigationController *setupNavi = [[UINavigationController alloc] initWithRootViewController:setupVC];
    UITabBarItem *thirdItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
    setupVC.tabBarItem = thirdItem;
    
    MetreViewController *metreVC = [[MetreViewController alloc] init];
    UINavigationController *metreNavi = [[UINavigationController alloc] initWithRootViewController:metreVC];
    UITabBarItem *forthItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:4];
    metreVC.tabBarItem = forthItem;
    
    self.viewControllers = @[poemListNavi, discoverNavi, metreNavi, setupNavi];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoCollectionPoemViewController) name:ToCollectionPoemViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoCollectionAuthorViewController) name:ToCollectionAuthorViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoSearchPoemSearchBar) name:ToSearchPoemSearchBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoFamousAuthorVC) name:TOFamousAuthorViewController object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoCollectionPoemViewController {
    self.selectedIndex = 3;
    [self performSelector:@selector(postToCollectionPoem) withObject:nil afterDelay:1.0];
}

- (void)gotoCollectionAuthorViewController {
    self.selectedIndex = 3;
    [self performSelector:@selector(postToCollectionAuthor) withObject:nil afterDelay:1.0];
}

- (void)gotoSearchPoemSearchBar {
    self.selectedIndex = 1;
    [self performSelector:@selector(postToSearchPoemSearchBar) withObject:nil afterDelay:1.0];
}

- (void)gotoFamousAuthorVC {
    self.selectedIndex = 1;
    [self performSelector:@selector(postToFamousAuthorVC) withObject:nil afterDelay:1.0];
}

- (void)postToCollectionPoem {
    [[NSNotificationCenter defaultCenter] postNotificationName:GoToCollectionPoemViewController object:self userInfo:nil];
}

- (void)postToCollectionAuthor {
    [[NSNotificationCenter defaultCenter] postNotificationName:GoToCollectionAuthotViewController object:self userInfo:nil];
}

- (void)postToSearchPoemSearchBar {
    [[NSNotificationCenter defaultCenter] postNotificationName:GoToSearchPoemSearchBar object:self userInfo:nil];
}

- (void)postToFamousAuthorVC {
    [[NSNotificationCenter defaultCenter] postNotificationName:GoToFamousAuthorViewController object:self userInfo:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
