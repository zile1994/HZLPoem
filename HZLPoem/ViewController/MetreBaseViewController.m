//
//  MetreBaseViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MetreBaseViewController.h"
#import "ToolClass.h"
#import "CollectionShilvViewController.h"

@interface MetreBaseViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation MetreBaseViewController

/**断网显示视图，点击跳转设置蜂窝网络*/
- (void)initNoSearchResultView {
    self.noSearchResultView = [[NoSearchResultView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toOpenNetwork)];
    [self.noSearchResultView addGestureRecognizer:tapGR];
}

- (void)toOpenNetwork {
    [ToolClass toSettingNetWork];
}

/**navigationBar 添加Item跳转到收藏界面*/
- (void)initToCollectionBarBtn {
    self.toCollectionBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(toCollectionGelvViewController)];
    self.navigationItem.rightBarButtonItem = self.toCollectionBarBtn;
}

- (void)toCollectionGelvViewController {
    CollectionShilvViewController *collectionGelvVC = [[CollectionShilvViewController alloc] init];
    [self.navigationController pushViewController:collectionGelvVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNoSearchResultView];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**去掉tableView 分割线左边15间距*/
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
