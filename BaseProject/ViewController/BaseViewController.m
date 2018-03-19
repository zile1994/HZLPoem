//
//  BaseViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewController.h"
#import "CollectionPoemViewController.h"
#import "CollectionAuthorViewController.h"

@interface BaseViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation BaseViewController

- (void)initNoSearchResultView {
    self.noSearchResultView = [[NoSearchResultView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toOpenNetwork)];
    [self.noSearchResultView addGestureRecognizer:tapGR];
}

- (void)toOpenNetwork {
    [ToolClass toSettingNetWork];
}

- (void)initNoResultOfSearchView {
    self.noResultOfSearchView = [[NoResultOfSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
}

- (NSMutableArray *)searchResultArr {
    if (!_searchResultArr) {
        _searchResultArr = [NSMutableArray array];
    }
    return _searchResultArr;
}

- (void)initSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
}

- (void)initToCollectionPoemBarBtn {
    self.toCollectionPoemBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(toCollectionPoemViewController)];
    self.navigationItem.rightBarButtonItem = self.toCollectionPoemBarBtn;
}

- (void)initToCollectionAuthorBarBtn {
    self.toCollectionAuthorBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(toCollectionAuthorViewController)];
    self.navigationItem.rightBarButtonItem = self.toCollectionAuthorBarBtn;
}

- (void)toCollectionPoemViewController {
    CollectionPoemViewController *collectionPoemVC = [[CollectionPoemViewController alloc] init];
    [self.navigationController pushViewController:collectionPoemVC animated:YES];
}

- (void)toCollectionAuthorViewController {
    CollectionAuthorViewController *collectionAuthorVC = [[CollectionAuthorViewController alloc] init];
    [self.navigationController pushViewController:collectionAuthorVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchController];
    [self initNoSearchResultView];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**去除搜索状态*/
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.searchController.searchBar.text = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)setPeekIndexPathSourceRectWithTableView:(UITableView *)tableView previewingContext:(id<UIViewControllerPreviewing>)previewingContext Location:(CGPoint)location {
    CGPoint peekPoint = [tableView convertPoint:location fromView:[previewingContext sourceView]];
    self.peekIndexPath = [tableView indexPathForRowAtPoint:peekPoint];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:self.peekIndexPath];
    CGRect peekRect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    previewingContext.sourceRect = peekRect;
    self.peekHeadLabel = [ToolClass setPeekHeadLabelWithTitle:nil BackgroundColor:kRGBColor(214, 0, 6) TitltColor:[UIColor whiteColor]];
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
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

@end
