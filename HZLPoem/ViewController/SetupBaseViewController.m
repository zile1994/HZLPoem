//
//  SetupBaseViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SetupBaseViewController.h"



@interface SetupBaseViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation SetupBaseViewController

- (void)initOperateCollectionView {
    self.operateCollectionView = [[OperateCollectionView alloc] initWithFrame:CGRectMake(-2, kHeight, kWidth + 4, 45)];
    self.operateCollectionView.layer.borderWidth = 1;
    self.operateCollectionView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.operateCollectionView.userInteractionEnabled = YES;
    self.operateCollectionView.allSelectedBtn.isSelecting = NO;
}

- (void)initSearchResultArr {
    self.searchResultArr = [NSMutableArray array];
}

- (void)initSelectedArr {
    self.selectedArr = [NSMutableArray array];
}

- (void)initSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
}

- (void)initNoCollectionView {
    self.noCollectionView = [[NoCollectionView alloc] init];
    self.noCollectionView.noCollectionImageView.image = [UIImage imageNamed:@"nocollectionPoem"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchController];
    [self initSearchResultArr];
    [self initSelectedArr];
    [self initNoCollectionView];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    // Do any additional setup after loading the view.
}

- (void)setDeleteBtnTitleColor {
    if (self.selectedArr.count > 0) {
        [self.operateCollectionView.delectedBtn setTitleColor:kRGBColor(64, 102, 150) forState:UIControlStateNormal];
    } else {
        [self.operateCollectionView.delectedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
