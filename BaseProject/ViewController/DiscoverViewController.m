//
//  DiscoverViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverViewModel.h"
#import "UIImageView+WebCache.h"
#import "DiscoverCell.h"
#import "FamousAuthorViewController.h"
#import "ShijingViewController.h"
#import "ChuciViewController.h"
#import "OtherGuShiWenViewController.h"
#import "SearchAllAuthorViewController.h"
#import "ResultOfSearchViewController.h"
#import "PromptView.h"
#import "ToolClass.h"


#define kDiscoverTableViewCellIdentifier  @"discoverTableCell"
extern NSString * const GoToSearchPoemSearchBar;
extern NSString * const GoToFamousAuthorViewController;
extern NSString * const TouchCollectionOtherViewControllerToTabBar;
NSString * const  TouchFamousAuthorAndSearchViewControllerPopToTabBar = @"TouchFamousAuthorAndSearchViewControllerPopToTabBar";

@interface DiscoverViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIViewControllerPreviewingDelegate>

//@property (nonatomic, strong) DiscoverViewModel *discoverVM;
//@property (nonatomic, strong) UIView *discoverHeadView;
@property (nonatomic, strong) UITableView *discoverTableView;
@property (nonatomic, strong) NSArray *sectionTitleArr;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSIndexPath *peekIndexPath;
@property (nonatomic, strong) UILabel *peekHeadLabel;
@property (nonatomic, strong) UIViewController *peekViewController;
@property (nonatomic, strong) NSArray *numberRowsArr;
@property (nonatomic, strong) NSArray *cellTitleArr;
@property (nonatomic, strong) NSArray *cellDescArr;
@property (nonatomic, strong) NSArray *cellImageArr;
@property (nonatomic, strong) NSArray *otherGuShiTypeArr;

@end

@implementation DiscoverViewController

- (NSArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@"古诗文作者", @"精选", @"启蒙", @"三百首精华", @"小学生必备", @"初中生必备", @"高中生必备"];
    }
    return _sectionTitleArr;
}

- (void)initNumberRowsArr {
    self.numberRowsArr = @[@2, @1, @3, @3, @2, @2, @2];
}

- (void)initCellTitleArr {
    self.cellTitleArr = @[@[@"古诗词大全", @"全部知名诗人"],
                          @[@"古文观止"],
                          @[@"诗经", @"楚辞", @"乐府"],
                          @[@"唐诗三百首", @"宋词三百首", @"古诗三百首"],
                          @[@"小学古诗", @"小学文言文"],
                          @[@"初中古诗", @"初中文言文"],
                          @[@"高中古诗", @"高中文言文"]];
}

- (void)initCellDescArr {
    self.cellDescArr = @[@[@"知名度最高的古诗人大全", @"按年代筛选古诗人"],
                         @[@"历代汉民族经典散文总集"],
                         @[@"中国最早的诗歌总集", @"中国首部浪漫主义诗歌总集", @"一部专收汉代以迄唐五代乐府诗的诗歌总集"],
                         @[@"熟读唐诗三百首，不会作诗也会吟", @"中国古代文学皇冠上光辉夺目的一颗巨钻", @"汇编了近两百位诗人的约三百首古诗全集"],
                         @[@"小学课本必修必背古诗词大全", @"小学课本必修必背文言文大全"],
                         @[@"初中课本必修必背古诗词大全", @"初中课本必修必背文言文大全"],
                         @[@"高中课本必修必背古诗词大全", @"高中课本必修必背文言文大全"]];
}

- (void)initCellImageArr {
    self.cellImageArr = @[@[@"famousauthor", @"authorimage"],
                          @[@"guwenguanzhi"],
                          @[@"shijing", @"chuci", @"yuefu"],
                          @[@"tssbs", @"scsbs", @"gssbs"],
                          @[@"xxgsw", @"xxwyw"],
                          @[@"czgsw", @"czwyw"],
                          @[@"gzgsw", @"gzwyw"]];
}

- (void)initOtherGuShiWenType {
    self.otherGuShiTypeArr = @[@[@"", @""],
                               @[@"guwenguanzhi"],
                               @[@"", @"", @"yuefu"],
                               @[@"tangshi.300", @"songci.300", @"gushi.300"],
                               @[@"gushi.xiaoxue", @"wyw.xiaoxue"],
                               @[@"gushi.chuzhong", @"wyw.chuzhong"],
                               @[@"gushi.gaozhong", @"wyw.gaozhong"]];
}

- (void)initDiscoverTableView {
    self.discoverTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.discoverTableView.delegate = self;
    self.discoverTableView.dataSource = self;
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入搜索的作者或作品名";
    [self.searchBar sizeToFit];
    self.discoverTableView.tableHeaderView = self.searchBar;
    [self.view addSubview:self.discoverTableView];
    [self.discoverTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.discoverTableView registerClass:[DiscoverCell class] forCellReuseIdentifier:kDiscoverTableViewCellIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    [self initNumberRowsArr];
    [self initCellTitleArr];
    [self initCellImageArr];
    [self initCellDescArr];
    [self initOtherGuShiWenType];
    [self initDiscoverTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSearchBarSearchPoem) name:GoToSearchPoemSearchBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toFamousAuthorViewController) name:GoToFamousAuthorViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(famousVCPopToTabBar) name:TouchCollectionOtherViewControllerToTabBar object:nil];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)famousVCPopToTabBar {
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[DiscoverViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    [self.searchBar resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.searchBar resignFirstResponder];
}

- (void)toSearchBarSearchPoem {
    /**发通知让其他tabBarItem子控制器退出到tabBar界面*/
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[DiscoverViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchFamousAuthorAndSearchViewControllerPopToTabBar object:self userInfo:nil];
    [self.searchBar becomeFirstResponder];
}

- (void)toFamousAuthorViewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchFamousAuthorAndSearchViewControllerPopToTabBar object:self userInfo:nil];
    /**避免以3Dtouch的方式重复退出*/
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[FamousAuthorViewController class]]) {
        FamousAuthorViewController *famousAuthorVC = [[FamousAuthorViewController alloc] init];
        [famousAuthorVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:famousAuthorVC animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillHidden {
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
}

#pragma mark TableView's methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.numberRowsArr[section] integerValue];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:kDiscoverTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLable.text = self.cellTitleArr[indexPath.section][indexPath.row];
    cell.descLabel.text = self.cellDescArr[indexPath.section][indexPath.row];
    cell.authorImageView.image = [UIImage imageNamed:self.cellImageArr[indexPath.section][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
    UIViewController *viewController = [[UIViewController alloc] init];
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
                viewController = [[FamousAuthorViewController alloc] init];
            } else {
                viewController = [[SearchAllAuthorViewController alloc] init];
            }
        }
            break;
        case 2: {
            if (indexPath.row == 0) {
                viewController = [[ShijingViewController alloc] init];
            } else if (indexPath.row == 1) {
                viewController = [[ChuciViewController alloc] init];
            } else {
                viewController = [[OtherGuShiWenViewController alloc] initOtherGuShiWenViewControllerWithType:self.otherGuShiTypeArr[indexPath.section][indexPath.row] TitleName:self.cellTitleArr[indexPath.section][indexPath.row]];
            }
            break;
        }
        default:
            viewController = [[OtherGuShiWenViewController alloc] initOtherGuShiWenViewControllerWithType:self.otherGuShiTypeArr[indexPath.section][indexPath.row] TitleName:self.cellTitleArr[indexPath.section][indexPath.row]];
            break;
    }
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitleArr[section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SearchBar's methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.text = nil;
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = self.searchBar.text;
    if (searchText.length == 0) {
        [self addPromptViewWithMessage:@"搜索关键字不能为空" Size:CGSizeMake(180, 70)];
    } else {
        ResultOfSearchViewController *resultOfSearchVC = [[ResultOfSearchViewController alloc] initResultOfSearchViewControllerWithKeywords:searchText];
        [resultOfSearchVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:resultOfSearchVC animated:YES];
    }
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

/**添加提示视图*/
- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    CGPoint peekPoint = [self.discoverTableView convertPoint:location fromView:[previewingContext sourceView]];
    self.peekIndexPath = [self.discoverTableView indexPathForRowAtPoint:peekPoint];
    CGRect rectInTableView = [self.discoverTableView rectForRowAtIndexPath:self.peekIndexPath];
    CGRect peekRect = [self.discoverTableView convertRect:rectInTableView toView:[self.discoverTableView superview]];
    previewingContext.sourceRect = peekRect;
    self.peekHeadLabel = [ToolClass setPeekHeadLabelWithTitle:nil BackgroundColor:kRGBColor(214, 0, 6) TitltColor:[UIColor whiteColor]];
    self.peekHeadLabel.text = self.cellTitleArr[self.peekIndexPath.section][self.peekIndexPath.row];
    switch (self.peekIndexPath.section) {
        case 0: {
            if (self.peekIndexPath.row == 0) {
                self.peekViewController = [[FamousAuthorViewController alloc] init];
            } else {
                self.peekViewController = [[SearchAllAuthorViewController alloc] init];
            }
        }
            break;
        case 2: {
            if (self.peekIndexPath.row == 0) {
                self.peekViewController = [[ShijingViewController alloc] init];
            } else if (self.peekIndexPath.row == 1) {
                self.peekViewController = [[ChuciViewController alloc] init];
            } else {
                self.peekViewController = [[OtherGuShiWenViewController alloc]initOtherGuShiWenViewControllerWithType:
                                           self.otherGuShiTypeArr[self.peekIndexPath.section][self.peekIndexPath.row] TitleName:
                                           self.cellTitleArr[self.peekIndexPath.section][self.peekIndexPath.row]];
            }
            break;
        }
        default:
            self.peekViewController = [[OtherGuShiWenViewController alloc] initOtherGuShiWenViewControllerWithType:
                                       self.otherGuShiTypeArr[self.peekIndexPath.section][self.peekIndexPath.row] TitleName:
                                       self.cellTitleArr[self.peekIndexPath.section][self.peekIndexPath.row]];
            break;
    }
    [self.peekViewController.view addSubview:self.peekHeadLabel];
    [self.peekHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.peekViewController.view);
        make.height.mas_equalTo(@44);
    }];
    return self.peekViewController;

}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.peekViewController setHidesBottomBarWhenPushed:YES];
    [self.peekHeadLabel removeFromSuperview];
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

@end
