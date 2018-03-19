//
//  SearchAuthorAllPoemListViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAuthorAllPoemListViewController.h"
#import "SearchAuthorAllPoemViewModel.h"
#import "SearchAuthorAllPoemCell.h"
#import "PoemDetailViewController.h"
#import "NoSearchResultView.h"
#import "ToolClass.h"


#define kSearchAuthorAllPoemTableViewCellIdentifier  @"kSearchAuthorAllPoemTableViewCell"

@interface SearchAuthorAllPoemListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SearchAuthorAllPoemViewModel *searchAuthorAllPoemVM;
@property (nonatomic, strong) UITableView *searchAuthorAllPoemTableView;

@end

@implementation SearchAuthorAllPoemListViewController

- (id)initSearchAuthorAllPoemListViewControllerWithAuthorName:(NSString *)authorName {
    if (self = [super init]) {
        self.authorName = authorName;
    }
    return self;
}

- (void)initSearchAuthorAllPoemVM {
    self.searchAuthorAllPoemVM = [[SearchAuthorAllPoemViewModel alloc] initSearchAuthorAllPoemViewModelWithAuthor:self.authorName];
}

- (void)initNoResultOfSearchView {
    [super initNoResultOfSearchView];
    self.noResultOfSearchView.noResultOfSearchLabel.text = @"暂无该作者作品";
}

- (void)initSearchAuthorAllPoemTableView {
    self.searchAuthorAllPoemTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.searchAuthorAllPoemTableView.delegate = self;
    self.searchAuthorAllPoemTableView.dataSource = self;
    self.searchAuthorAllPoemTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.searchAuthorAllPoemTableView];
    [self.searchAuthorAllPoemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.searchAuthorAllPoemTableView registerClass:[SearchAuthorAllPoemCell class] forCellReuseIdentifier:kSearchAuthorAllPoemTableViewCellIdentifier];
    __weak __typeof(self) _self = self;
    self.searchAuthorAllPoemTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.searchAuthorAllPoemVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.searchAuthorAllPoemTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               if (_self.searchAuthorAllPoemVM.rowNumber == 0) {
                   [_self.noSearchResultView removeFromSuperview];
                   _self.searchAuthorAllPoemTableView.tableHeaderView = _self.noResultOfSearchView;
               } else {
                   [_self.noResultOfSearchView removeFromSuperview];
                   _self.searchAuthorAllPoemTableView.tableHeaderView = nil;
               }
               [_self.searchAuthorAllPoemTableView reloadData];
           }
           [_self.searchAuthorAllPoemTableView.header endRefreshing];
       }];
    }];
    self.searchAuthorAllPoemTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [_self.searchAuthorAllPoemVM getMoreDataCompletionHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
               [_self.searchAuthorAllPoemTableView.footer endRefreshing];
           } else {
               [_self.searchAuthorAllPoemTableView reloadData];
               if (_self.searchAuthorAllPoemVM.hasMore) {
                   [_self.searchAuthorAllPoemTableView.footer endRefreshing];
               } else {
                   [_self.searchAuthorAllPoemTableView.footer endRefreshingWithNoMoreData];
               }
           }
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@全集", self.authorName];
    [self initSearchAuthorAllPoemVM];
    [self initNoResultOfSearchView];
    [self initSearchAuthorAllPoemTableView];
    [self.searchAuthorAllPoemTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchAuthorAllPoemVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchAuthorAllPoemCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchAuthorAllPoemTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.xingshiLabel.text = [self.searchAuthorAllPoemVM getXingshiForRow:indexPath.row];
    cell.chaodaiLabel.text = [self.searchAuthorAllPoemVM getChaodaiForRow:indexPath.row];
    cell.titleLabel.text = [self.searchAuthorAllPoemVM getTitleForRow:indexPath.row];
    cell.viewStrLeixingLabel.text = [NSString stringWithFormat:@"%@分(%@人评价) 浏览次数:%@  分类:%@", [self.searchAuthorAllPoemVM getStrForRow:indexPath.row], [self.searchAuthorAllPoemVM getStrCountForRow:indexPath.row], [self.searchAuthorAllPoemVM getViewsForRow:indexPath.row], [self.searchAuthorAllPoemVM getLeixingForRow:indexPath.row]];
    cell.yuanwenLabel.text = [self.searchAuthorAllPoemVM getYuanwenForRow:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                                              [self.searchAuthorAllPoemVM getViewidForRow:indexPath.row] PoemTitle:
                                              [self.searchAuthorAllPoemVM getTitleForRow:indexPath.row] AuthorName:nil];
    [self.navigationController pushViewController:poemDetailVC animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.searchAuthorAllPoemTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.searchAuthorAllPoemVM getTitleForRow:self.peekIndexPath.row];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.searchAuthorAllPoemVM getViewidForRow:self.peekIndexPath.row] PoemTitle:
                               [self.searchAuthorAllPoemVM getTitleForRow:self.peekIndexPath.row] AuthorName:nil];
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
