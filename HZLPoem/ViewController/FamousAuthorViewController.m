//
//  FamousAuthorViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "FamousAuthorViewController.h"
#import "FamousAuthorViewModel.h"
#import "FamousAuthorDetailViewController.h"
#import "SectionHeadView.h"

#define kFamousAuthorTableViewCellIdentifier  @"FamousAuthorCell"
#define kFamousAuthorTableViewSectionHeadViewIdentifier  @"AuthorTableViewSectionHeadView"

@interface FamousAuthorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FamousAuthorViewModel *famousAuthorVM;
@property (nonatomic, strong) UITableView *famousAuthorTableView;

@end

@implementation FamousAuthorViewController

- (void)initFamousAuthorVM {
    self.famousAuthorVM = [[FamousAuthorViewModel alloc] init];
}

- (void)initFamousAuthorTableView {
    self.famousAuthorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.famousAuthorTableView.delegate = self;
    self.famousAuthorTableView.dataSource = self;
    [self.view addSubview:self.famousAuthorTableView];
    [self.famousAuthorTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.famousAuthorTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFamousAuthorTableViewCellIdentifier];
    [self.famousAuthorTableView registerClass:[SectionHeadView class] forHeaderFooterViewReuseIdentifier:kFamousAuthorTableViewSectionHeadViewIdentifier];
    __weak __typeof(self) _self = self;
    self.famousAuthorTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.famousAuthorVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.famousAuthorTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.famousAuthorTableView.tableHeaderView = nil;
               [_self.famousAuthorTableView reloadData];
           }
           [self.famousAuthorTableView.header endRefreshing];
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"古诗词大咖";
    [self initToCollectionAuthorBarBtn];
    [self initFamousAuthorVM];
    [self initFamousAuthorTableView];
    [self.famousAuthorTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.famousAuthorVM.rowNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.famousAuthorVM getAuthorArrForSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFamousAuthorTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldFlatFontOfSize:19];
    NSArray *authorArr = [self.famousAuthorVM getAuthorArrForSection:indexPath.section];
    cell.textLabel.text = authorArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *author = [self.famousAuthorVM getAuthorArrForSection:indexPath.section];
    FamousAuthorDetailViewController *famousAuthorDetailVC = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:author[indexPath.row]];
    [self.navigationController pushViewController:famousAuthorDetailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFamousAuthorTableViewSectionHeadViewIdentifier];
    sectionHeadView.titleLabel.text = self.famousAuthorVM.titleArr[section];
    sectionHeadView.titleLabel.font = [UIFont systemFontOfSize:15];
    return sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.famousAuthorTableView previewingContext:previewingContext Location:location];
    NSArray *authorArr = [self.famousAuthorVM getAuthorArrForSection:self.peekIndexPath.section];
    self.peekHeadLabel.text = authorArr[self.peekIndexPath.row];
    self.peekViewController = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:authorArr[self.peekIndexPath.row]];
    [self.peekViewController.view addSubview:self.peekHeadLabel];
    [self.peekHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.peekViewController.view);
        make.height.mas_equalTo(@44);
    }];
    return self.peekViewController;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [super previewingContext:previewingContext commitViewController:viewControllerToCommit];
}


//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
