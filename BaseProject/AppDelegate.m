//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "PoemTabBarController.h"
#import "CollectionPoemViewController.h"
#import "CollectionAuthorViewController.h"
//#import "UMSocial.h"、


#define kNavigationTitleFont  20
#define kNavigationTitleColor  [UIColor whiteColor]
//#define kNavigationBarTintColor  [UIColor colorWithRed:210 / 255.0 green:130 / 255.0 blue:122 / 255 alpha:1.0]

NSString * const ToCollectionPoemViewController = @"ToCollectionPoemViewController";
NSString * const ToCollectionAuthorViewController = @"ToCollectionAuthorViewController";
NSString * const ToSearchPoemSearchBar = @"ToSearchPoemSearchBar";
NSString * const TOFamousAuthorViewController = @"TOFamousAuthorViewController";

@interface AppDelegate ()

@property (nonatomic, strong) PoemTabBarController *tabBarVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    [self initializeWithApplication:application];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tabBarVC = [[PoemTabBarController alloc] init];
    self.window.rootViewController = self.tabBarVC;
    
    self.tabBarVC.tabBar.tintColor = kRGBColor(213, 106, 107);
    
//    [UMSocialData setAppKey:@"56eb5eb167e58e5b7a0020a0"];
    [self add3DTouch];
    [self setTabBar];
    [self setNavigationBar];
    return YES;
}

- (void)setTabBar {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [self.window makeKeyAndVisible];
}

- (void)setNavigationBar {
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kNavigationTitleFont], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarbackgronudimage"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBarTintColor:kRGBColor(213, 0,0)];
//    [[UINavigationBar appearance] setBarTintColor:kNavigationBarTintColor];

}

- (void)add3DTouch {
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"one" localizedTitle:@"搜索" localizedSubtitle:nil icon:icon1 userInfo:nil];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"Two" localizedTitle:@"收藏的作者" localizedSubtitle:nil icon:icon2 userInfo:nil];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeBookmark];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:@"收藏的古文" localizedSubtitle:nil icon:icon3 userInfo:nil];
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite];
    UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc] initWithType:@"four" localizedTitle:@"诗词大咖" localizedSubtitle:nil icon:icon4 userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[item2, item3, item4, item1];
}

/**添加3D Touch主屏幕唤醒列表*/
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.localizedTitle isEqualToString:@"收藏的古文"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ToCollectionPoemViewController object:self userInfo:nil];
    } else if ([shortcutItem.localizedTitle isEqualToString:@"收藏的作者"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ToCollectionAuthorViewController object:self userInfo:nil];
    } else if ([shortcutItem.localizedTitle isEqualToString:@"搜索"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ToSearchPoemSearchBar object:self userInfo:nil];
    } else if ([shortcutItem.localizedTitle isEqualToString:@"诗词大咖"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TOFamousAuthorViewController object:self userInfo:nil];
    } else {
    }
}

@end
