//
//  ChineseRhymeViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChineseRhymeViewController.h"
#import "ChineseRhymeViewModel.h"
#import "ChineseRhymeCell.h"
#import "ToolClass.h"
#import "ChineseRhymeDetailViewController.h"

#define kChineseRhymeTableViewCellIdentifeir  @"ChineseRhymeTableViewCell"

@interface ChineseRhymeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ChineseRhymeViewModel *chineseRhymeVM;
@property (nonatomic, strong) UITableView *chineseRhymeTableView;

@end

@implementation ChineseRhymeViewController

- (id)initChineseRhymeViewControllerWithTypeID:(NSString *)typeID TypeName:(NSString *)typeName {
    if (self = [super init]) {
        self.typeID = typeID;
        self.typeName = typeName;
    }
    return self;
}

- (void)initChineseRhymeVM {
    self.chineseRhymeVM = [[ChineseRhymeViewModel alloc] initChineseRhymeViewModelWithTypeID:self.typeID];
}

- (void)initChineseRhymeTableView {
    self.chineseRhymeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.chineseRhymeTableView.delegate = self;
    self.chineseRhymeTableView.dataSource = self;
    self.chineseRhymeTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.chineseRhymeTableView];
    [self.chineseRhymeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.chineseRhymeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kChineseRhymeTableViewCellIdentifeir];
    __weak typeof(self) _self = self;
    self.chineseRhymeTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.chineseRhymeVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
           } else {
               [_self.chineseRhymeTableView reloadData];
           }
           [_self.chineseRhymeTableView.header endRefreshing];
       }];
    }];
    self.chineseRhymeTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [_self.chineseRhymeVM getMoreDataCompletionHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
               [_self.chineseRhymeTableView.footer endRefreshing];
           } else {
               [_self.chineseRhymeTableView reloadData];
               if (_self.chineseRhymeVM.isHasMore) {
                   [_self.chineseRhymeTableView.footer endRefreshing];
               } else {
                   [_self.chineseRhymeTableView.footer endRefreshingWithNoMoreData];
               }
           }
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.typeName;
    [self initChineseRhymeVM];
    [self initChineseRhymeTableView];
    [self.chineseRhymeTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chineseRhymeVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kChineseRhymeTableViewCellIdentifeir];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyHeadForRow:indexPath.row]];
    cell.detailTextLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyMotherForRow:indexPath.row]];
    cell.textLabel.font = [UIFont boldFlatFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChineseRhymeDetailViewController *chineseRhyDetailVC = [[ChineseRhymeDetailViewController alloc] initChineseRhymeDetailViewControllerWithRhyHead:
        [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyHeadForRow:indexPath.row]] rhyMother:
        [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyMotherForRow:indexPath.row]] RhyContent:
        [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyContentForRow:indexPath.row]]];
    [self.navigationController pushViewController:chineseRhyDetailVC animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.chineseRhymeTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.chineseRhymeVM getRhyHeadForRow:self.peekIndexPath.row];
    self.peekViewController = [[ChineseRhymeDetailViewController alloc] initChineseRhymeDetailViewControllerWithRhyHead:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyHeadForRow:self.peekIndexPath.row]] rhyMother:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyMotherForRow:self.peekIndexPath.row]] RhyContent:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.chineseRhymeVM getRhyContentForRow:self.peekIndexPath.row]]];
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
