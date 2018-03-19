//
//  SetupViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SetupViewController.h"
#import "CollectionPoemViewController.h"
#import "CollectionAuthorViewController.h"
#import "AboutUsViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PromptView.h"
#import "ToolClass.h"
#import "SDImageCache.h"
#import "CollectionShilvViewController.h"
#import "BaseTableViewCell.h"


#define kSetupTableViewCellIdentifier  @"setupTableViewCellIdentifer"
#define kNumberOfSection  3
#define kPromptViewSize  CGSizeMake(170, 70)
extern NSString * const GoToCollectionPoemViewController;
extern NSString * const GoToCollectionAuthotViewController;
extern NSString * const TouchFamousAuthorAndSearchViewControllerPopToTabBar;
extern NSString * const CollectionAuthorPath;
extern NSString * const CollectionRhymePath;
extern NSString * const CollectionGelvPath;
extern NSString * const CollectionPoemPath;
NSString * const TouchCollectionOtherViewControllerToTabBar = @"TouchCollectionOtherViewControllerToTabBar";


@interface SetupViewController ()<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *setupTableView;
@property (nonatomic, strong) NSArray *sectionTitleArr;
@property (nonatomic, strong) UIView *setupTableViewFootView;
@property (nonatomic, strong) NSArray *collectionArr;
@property (nonatomic, strong) UILabel *peekHeadLabel;
@property (nonatomic, strong) UIViewController *peekViewController;
@property (nonatomic, strong) NSIndexPath *peekIndexPath;
@property (nonatomic, strong) NSArray *cellTextLabelTitleArr;

@end

@implementation SetupViewController

- (void)initCollectionArr {
    NSString *collectionPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *collectionPoemPath = [collectionPath stringByAppendingPathComponent:CollectionPoemPath];
    NSString *collectionAuthorPath = [collectionPath stringByAppendingPathComponent:CollectionAuthorPath];
    NSString *collectionRhymePath = [collectionPath stringByAppendingPathComponent:CollectionRhymePath];
    NSString *collectionGelvPath = [collectionPath stringByAppendingPathComponent:CollectionGelvPath];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSMutableArray *collectionPoemArr = [NSMutableArray array];
    NSMutableArray *collectionAuthorArr = [NSMutableArray array];
    NSMutableArray *collectionRhymeArr = [NSMutableArray array];
    NSMutableArray *collectionGelvArr = [NSMutableArray array];
    
    if ([manager fileExistsAtPath:collectionPoemPath]) {
        collectionPoemArr = [NSKeyedUnarchiver unarchiveObjectWithFile:collectionPoemPath];
    }
    if ([manager fileExistsAtPath:collectionAuthorPath]) {
        collectionAuthorArr = [NSKeyedUnarchiver unarchiveObjectWithFile:collectionAuthorPath];
    }
    if ([manager fileExistsAtPath:collectionRhymePath]) {
        collectionRhymeArr = [NSKeyedUnarchiver unarchiveObjectWithFile:collectionRhymePath];
    }
    if ([manager fileExistsAtPath:collectionGelvPath]) {
        collectionGelvArr = [NSKeyedUnarchiver unarchiveObjectWithFile:collectionGelvPath];
    }
    
    NSNumber *collectionPoemCount = [NSNumber numberWithInteger:collectionPoemArr.count];
    NSNumber *collectionAuthorCount = [NSNumber numberWithInteger:collectionAuthorArr.count];
    NSNumber *collectionRhymeCount = [NSNumber numberWithInteger:collectionRhymeArr.count];
    NSNumber *collectionGelvCount = [NSNumber numberWithInteger:collectionGelvArr.count];
    self.collectionArr = @[collectionPoemCount, collectionAuthorCount, collectionRhymeCount, collectionGelvCount];
}

- (void)initSectionTitleArr {
    self.sectionTitleArr = @[@"我的收藏", @"系统设置", @"意见反馈"];
}

- (void)initCellTextLabelArr {
    self.cellTextLabelTitleArr = @[@[@"收藏的古文", @"收藏的作者", @"收藏的诗律"],
                                   @[@"清空缓存"],
                                   @[@"关于我们", @"意见反馈", @"为我们打分"]];
}

- (void)initSetupTableView {
    self.setupTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.setupTableView.delegate = self;
    self.setupTableView.dataSource = self;
    self.setupTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.setupTableView];
    [self.setupTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.setupTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSetupTableViewCellIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self initCollectionArr];
    [self initSectionTitleArr];
    [self initCellTextLabelArr];
    [self initSetupTableView];
    NSString *dtr = [UIDevice currentDevice].name;
    NSLog(@"%@", dtr);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoCollectionPoemVC) name:GoToCollectionPoemViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoCollectionAuthorVC) name:GoToCollectionAuthotViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToTabBar) name:TouchFamousAuthorAndSearchViewControllerPopToTabBar object:nil];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)popToTabBar {
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[SetupViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self showCacheDic];
    [self initCollectionArr];
    [self.setupTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kNumberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSetupTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.cellTextLabelTitleArr[indexPath.section][indexPath.row];
    NSInteger count;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            count = [self.collectionArr[indexPath.row] integerValue];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu篇", count];
        } else if (indexPath.row ==1){
            count = [self.collectionArr[indexPath.row] integerValue];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu位", count];
        } else if (indexPath.row == 2) {
            NSInteger rhymeCount = [self.collectionArr[indexPath.row] integerValue];
            NSInteger gelvCount = [self.collectionArr.lastObject integerValue];
            count = rhymeCount + gelvCount;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu篇", count];
        }
        if (count == 0) {
            cell.detailTextLabel.text = @"无";
        }
    }
    if (indexPath.section == 1) {
        cell.detailTextLabel.text = [self showCacheDic];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController;
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
                viewController = [[CollectionPoemViewController alloc] init];
            } else if (indexPath.row == 1) {
                viewController = [[CollectionAuthorViewController alloc] init];
            } else if (indexPath.row == 2) {
                viewController = [[CollectionShilvViewController alloc] init];
            }
        }
            break;
        case 1: {
            [self showAlertControllerWithSection:indexPath.section Row:indexPath.row];
        }
            break;
        case 2: {
            if (indexPath.row == 0) {
                viewController = [[AboutUsViewController alloc] init];
            } else {
            }
        }
            break;
        default:
            break;
    }
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self displayMFMainComposeViewController];
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        [self addPromptViewWithMessage:@"不上架，不打分😂" Size:kPromptViewSize];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayMFMainComposeViewController {
    MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
    emailVC.mailComposeDelegate = self;
    [emailVC setSubject:@"诗词古韵改进建议"];
    NSArray *toRecipients = @[@"zile1994@icloud.com"];
    [emailVC setToRecipients:toRecipients];
    [self presentViewController:emailVC animated:YES completion:nil];
}


- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
}

- (NSString *)showCacheDic {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths.firstObject;
    NSString *sizeOfCacheFile;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize = folderSize + [fileManager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        folderSize = folderSize + [[SDImageCache sharedImageCache] getSize];
        CGFloat sizeOfFile = folderSize / (1024 * 1024);
        if (sizeOfFile >= 100) {
            return @"99M+";
        }
        sizeOfCacheFile = [NSString stringWithFormat:@"%.2fM", sizeOfFile];
        if ([sizeOfCacheFile isEqualToString:@"0.00M"]) {
            sizeOfCacheFile = @"0M";
        }
    }
    return sizeOfCacheFile;
}

- (void)showAlertControllerWithSection:(NSInteger)section Row:(NSInteger)row {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除所有缓存记录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [pathArr objectAtIndex:0];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            NSArray *childerFiles=[fileManager subpathsAtPath:path];
            for (NSString *fileName in childerFiles) {
                //如有需要，加入条件，过滤掉不想删除的文件
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
        [[SDImageCache sharedImageCache] cleanDisk];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
        [self.setupTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)gotoCollectionPoemVC {
    /**发通知让另外tabBarItem界面退出到tabBar界面*/
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchCollectionOtherViewControllerToTabBar object:self userInfo:nil];
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    /**避免以3Dtouch的方式重复退出*/
    if (![vc isKindOfClass:[SetupViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
        CollectionPoemViewController *collectionPoemVC = [[CollectionPoemViewController alloc] init];
        [collectionPoemVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:collectionPoemVC animated:YES];
    
}

- (void)gotoCollectionAuthorVC {
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchCollectionOtherViewControllerToTabBar object:self userInfo:nil];
    UIViewController *vc = self.navigationController.viewControllers.lastObject;

    if (![vc isKindOfClass:[SetupViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    CollectionAuthorViewController *collectionAuthorVC = [[CollectionAuthorViewController alloc] init];
    [collectionAuthorVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:collectionAuthorVC animated:YES];
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    CGPoint peekPoint = [self.setupTableView convertPoint:location fromView:[previewingContext sourceView]];
    self.peekIndexPath = [self.setupTableView indexPathForRowAtPoint:peekPoint];
    CGRect rectInTableView = [self.setupTableView rectForRowAtIndexPath:self.peekIndexPath];
    CGRect peekRect = [self.setupTableView convertRect:rectInTableView toView:[self.setupTableView superview]];
    previewingContext.sourceRect = peekRect;
    self.peekHeadLabel = [ToolClass setPeekHeadLabelWithTitle:nil BackgroundColor:kRGBColor(214, 0, 6) TitltColor:[UIColor whiteColor]];
    switch (self.peekIndexPath.section) {
        case 0:{
            if (self.peekIndexPath.row == 0) {
                self.peekViewController = [[CollectionPoemViewController alloc] init];
                self.peekHeadLabel.text = @"收藏的古文";
            } else if (self.peekIndexPath.row == 1) {
                self.peekViewController = [[CollectionAuthorViewController alloc] init];
                self.peekHeadLabel.text = @"收藏的作者";
            } else {
                self.peekViewController = [[CollectionShilvViewController alloc] init];
                self.peekHeadLabel.text = @"收藏的诗律";
            }
        }
            break;
        default:
            return nil;
            break;
    }
    [self.peekViewController.view addSubview:self.peekHeadLabel];
    [self.peekHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.peekViewController.view);
        make.height.mas_equalTo(@44);
    }];
    return self.peekViewController;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.peekHeadLabel removeFromSuperview];
    [self.peekViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:self.peekViewController animated:YES];
}

/*
#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
///var/mobile/Containers/Data/Application/75409443-69B3-4713-A747-D5ABFEE2F0F7/Library/Caches
@end
