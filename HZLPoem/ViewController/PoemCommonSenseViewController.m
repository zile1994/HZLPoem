//
//  PoemCommonSenseViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseViewController.h"
#import "PoemCommonSenseViewModel.h"
#import "ToolClass.h"
#import "PoemCommonSenseDetailViewController.h"


#define kPoemCommonSenseTableViewCellIdentifer  @"PoemCommonSenseTabelViewCell"

@interface PoemCommonSenseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *poemCommonSenseTableView;
@property (nonatomic, strong) PoemCommonSenseViewModel *poemCommonSenseVM;

@end

@implementation PoemCommonSenseViewController

- (void)initPoemCommmonSenseVM {
    self.poemCommonSenseVM = [[PoemCommonSenseViewModel alloc] init];
}

- (void)initPoemCommonSenseTableView {
    self.poemCommonSenseTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.poemCommonSenseTableView.delegate = self;
    self.poemCommonSenseTableView.dataSource = self;
    self.poemCommonSenseTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.poemCommonSenseTableView];
    [self.poemCommonSenseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.poemCommonSenseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kPoemCommonSenseTableViewCellIdentifer];
    __weak typeof(self) _self = self;
    self.poemCommonSenseTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.poemCommonSenseVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.poemCommonSenseTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.poemCommonSenseTableView.tableHeaderView = nil;
               [_self.poemCommonSenseTableView reloadData];
           }
           [_self.poemCommonSenseTableView.header endRefreshing];
       }];
    }];
    self.poemCommonSenseTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [_self.poemCommonSenseVM getMoreDataCompletionHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
               [_self.poemCommonSenseTableView.footer endRefreshing];
           } else {
               [_self.poemCommonSenseTableView reloadData];
               if (_self.poemCommonSenseVM.isHasMore) {
                   [_self.poemCommonSenseTableView.footer endRefreshing];
               } else {
                   [_self.poemCommonSenseTableView.footer endRefreshingWithNoMoreData];
               }
           }
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"诗词常识集";
    [self initPoemCommmonSenseVM];
    [self initPoemCommonSenseTableView];
    [self.poemCommonSenseTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poemCommonSenseVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPoemCommonSenseTableViewCellIdentifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getQuestionForRow:indexPath.row]];
    cell.textLabel.font = [UIFont boldFlatFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemCommonSenseDetailViewController *poemCommonSenseDetailVC = [[PoemCommonSenseDetailViewController alloc] initPoemCommonSenseDetailViewControllerWithFID:
        [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getFIDForRow:indexPath.row]] Question:
        [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getQuestionForRow:indexPath.row]]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:poemCommonSenseDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.poemCommonSenseTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getQuestionForRow:self.peekIndexPath.row]];
    self.peekViewController = [[PoemCommonSenseDetailViewController alloc] initPoemCommonSenseDetailViewControllerWithFID:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getFIDForRow:self.peekIndexPath.row]] Question:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseVM getQuestionForRow:self.peekIndexPath.row]]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
