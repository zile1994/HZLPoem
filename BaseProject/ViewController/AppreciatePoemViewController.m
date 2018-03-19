//
//  AppreciatePoemViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppreciatePoemViewController.h"
#import "AppreciatePoemViewModel.h"
#import "ToolClass.h"
#import "PoemCommonSenseDetailViewController.h"

#define kAppreciatePoemTableViewCellIdentifier  @"AppreciatePoemTableViewCell"

@interface AppreciatePoemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appreciatePoemTableView;
@property (nonatomic, strong) AppreciatePoemViewModel *appreciatePoemVM;

@end

@implementation AppreciatePoemViewController

- (void)initAppreciatePoemVM {
    self.appreciatePoemVM = [[AppreciatePoemViewModel alloc] init];
}

- (void)initAppreciatePoemTableView {
    self.appreciatePoemTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.appreciatePoemTableView.delegate = self;
    self.appreciatePoemTableView.dataSource = self;
    self.appreciatePoemTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.appreciatePoemTableView];
    [self.appreciatePoemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.appreciatePoemTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kAppreciatePoemTableViewCellIdentifier];
    __weak typeof(self) _self = self;
    self.appreciatePoemTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.appreciatePoemVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.appreciatePoemTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.appreciatePoemTableView.tableHeaderView = nil;
               [_self.appreciatePoemTableView reloadData];
           }
           [_self.appreciatePoemTableView.header endRefreshing];
       }];
    }];
    self.appreciatePoemTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [_self.appreciatePoemVM getMoreDataCompletionHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
               [_self.appreciatePoemTableView.footer endRefreshing];
           } else {
               [_self.appreciatePoemTableView reloadData];
               if (_self.appreciatePoemVM.isHasMore) {
                   [_self.appreciatePoemTableView.footer endRefreshing];
               } else {
                   [_self.appreciatePoemTableView.footer endRefreshingWithNoMoreData];
               }
           }
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"如何欣赏诗词";
    [self initAppreciatePoemVM];
    [self initAppreciatePoemTableView];
    [self.appreciatePoemTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appreciatePoemVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kAppreciatePoemTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.textColor = kRGBColor(253, 147, 66);
    cell.detailTextLabel.font = [UIFont boldFlatFontOfSize:18];
    cell.detailTextLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getQuestionForRow:indexPath.row]];
    cell.textLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getAuthorForRow:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemCommonSenseDetailViewController *poemCommonSenseDetailVC = [[PoemCommonSenseDetailViewController alloc] initPoemCommonSenseDetailViewControllerWithFID:
        [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getFIDForRow:indexPath.row]] Question:
        [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getQuestionForRow:indexPath.row]]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:poemCommonSenseDetailVC animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.appreciatePoemTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getQuestionForRow:self.peekIndexPath.row]];
    self.peekViewController = [[PoemCommonSenseDetailViewController alloc] initPoemCommonSenseDetailViewControllerWithFID:
        [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getFIDForRow:self.peekIndexPath.row]] Question:
        [ToolClass unsimplifiedExchangeToSimplified:[self.appreciatePoemVM getQuestionForRow:self.peekIndexPath.row]]];
    [self.peekViewController.view addSubview:self.peekHeadLabel];
    [self.peekHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.peekViewController.view);
        make.height.mas_equalTo(@44);
    }];
    return self.peekViewController;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [super previewingContext:previewingContext commitViewController:viewControllerToCommit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
