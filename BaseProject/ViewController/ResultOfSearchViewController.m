//
//  ResultOfSearchViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/10.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ResultOfSearchViewController.h"
#import "ResultOfSearchViewModel.h"
#import "SearchAuthorAllPoemCell.h"
#import "PoemDetailViewController.h"
#import "NoSearchResultView.h"
#import "ToolClass.h"
#import "NoResultOfSearchView.h"


#define kResultoOfSearchTableViewCellIdentifier  @"resultoOfSearchTableViewCell"

@interface ResultOfSearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *resultoOfSearchTableView;
@property (nonatomic, strong) ResultOfSearchViewModel *resultOfSearchVM;

@end

@implementation ResultOfSearchViewController

- (id)initResultOfSearchViewControllerWithKeywords:(NSString *)keywords {
    if (self = [super init]) {
        self.keywords = keywords;
    }
    return self;
}

- (void)initResultOfSearchVM {
    self.resultOfSearchVM = [[ResultOfSearchViewModel alloc] initResultOfSearchViewModelWithKeyword:self.keywords];
}

- (void)initNoResultOfSearchView {
    [super initNoResultOfSearchView];
    self.noResultOfSearchView.noResultOfSearchLabel.text = @"无符合关键字的作品";
}

- (void)initResultOfSearchTableView {
    self.resultoOfSearchTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.resultoOfSearchTableView.delegate = self;
    self.resultoOfSearchTableView.dataSource = self;
    [self.view addSubview:self.resultoOfSearchTableView];
    self.resultoOfSearchTableView.tableFooterView = [UIView new];
    [self.resultoOfSearchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.resultoOfSearchTableView registerClass:[SearchAuthorAllPoemCell class] forCellReuseIdentifier:kResultoOfSearchTableViewCellIdentifier];
    __weak __typeof(self)  _self = self;
    self.resultoOfSearchTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.resultOfSearchVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.resultoOfSearchTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               if (_self.resultOfSearchVM.rowNumber == 0) {
                   [_self.noSearchResultView removeFromSuperview];
                   _self.resultoOfSearchTableView.tableHeaderView = _self.noResultOfSearchView;
               } else {
                   [_self.noSearchResultView removeFromSuperview];
                   [_self.noResultOfSearchView removeFromSuperview];
                   _self.resultoOfSearchTableView.tableHeaderView = nil;
                   _self.title = _self.keywords;
               }
           }
           [_self.resultoOfSearchTableView.header endRefreshing];
           [_self.resultoOfSearchTableView reloadData];
        }];
    }];
    self.resultoOfSearchTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_self.resultOfSearchVM getMoreDataCompletionHandle:^(NSError *error) {
            if (error) {
                [_self showErrorMsg:error.localizedDescription];
                [_self.resultoOfSearchTableView.footer endRefreshing];
            } else {
                [_self.resultoOfSearchTableView reloadData];
                if (_self.resultOfSearchVM.isHasMore) {
                    [_self.resultoOfSearchTableView.footer endRefreshing];
                } else {
                    [_self.resultoOfSearchTableView.footer endRefreshingWithNoMoreData];
                }
            }
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initResultOfSearchVM];
    [self initNoResultOfSearchView];
    [self initResultOfSearchTableView];
    [self.resultoOfSearchTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultOfSearchVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchAuthorAllPoemCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultoOfSearchTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.xingshiLabel.text = [self.resultOfSearchVM getXingshiForRow:indexPath.row];
    cell.chaodaiLabel.text = [self.resultOfSearchVM getChaodaiForRow:indexPath.row];
    cell.titleLabel.text = [self.resultOfSearchVM getTitleForRow:indexPath.row];
    cell.viewStrLeixingLabel.text = [NSString stringWithFormat:@"%@分(%@人评价) 浏览次数:%@  分类:%@", [self.resultOfSearchVM getStarForRow:indexPath.row], [self.resultOfSearchVM getStarCountForRow:indexPath.row], [self.resultOfSearchVM getViewsForRow:indexPath.row], [self.resultOfSearchVM getLeixingForRow:indexPath.row]];
    cell.yuanwenLabel.text = [self.resultOfSearchVM getYuanWenForRow:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                                              [self.resultOfSearchVM getViewIdForRow:indexPath.row] PoemTitle:
                                              [self.resultOfSearchVM getTitleForRow:indexPath.row] AuthorId:
                                              [self.resultOfSearchVM getAuthorIdForRow:indexPath.row] AuthorName:
                                              [self.resultOfSearchVM getAuthorForRow:indexPath.row]];
    [self.navigationController pushViewController:poemDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.resultoOfSearchTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.resultOfSearchVM getTitleForRow:self.peekIndexPath.row];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.resultOfSearchVM getViewIdForRow:self.peekIndexPath.row] PoemTitle:
                               [self.resultOfSearchVM getTitleForRow:self.peekIndexPath.row] AuthorId:
                               [self.resultOfSearchVM getAuthorIdForRow:self.peekIndexPath.row] AuthorName:
                               [self.resultOfSearchVM getAuthorForRow:self.peekIndexPath.row]];
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
