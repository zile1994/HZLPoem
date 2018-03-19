//
//  YunzijiViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YunzijiViewController.h"
#import "YunzijiViewModel.h"
#import "ToolClass.h"
#import "MetreCell.h"
#import "YunzijiCell.h"
#import "SelectedButton.h"
#import "ChineseRhymeViewController.h"
#import "CollectionShilvViewController.h"


#define kYunzijiTableViewCellIdentifier  @"yunzijiTableViewCell"

@interface YunzijiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *yunzijiTableView;
@property (nonatomic, strong) YunzijiViewModel *yunzijiVM;

@end

@implementation YunzijiViewController

- (void)initYunzijiViewModel {
    self.yunzijiVM = [[YunzijiViewModel alloc] init];
}

- (void)initYunzijiTableView {
    self.yunzijiTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.yunzijiTableView.delegate = self;
    self.yunzijiTableView.dataSource = self;
    self.yunzijiTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.yunzijiTableView];
    [self.yunzijiTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.yunzijiTableView registerClass:[YunzijiCell class] forCellReuseIdentifier:kYunzijiTableViewCellIdentifier];
    __weak typeof(self) _self = self;
    self.yunzijiTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.yunzijiVM getDataFromNetCompleteHandle:^(NSError *error) {
           if (error) {
               _self.yunzijiTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.yunzijiTableView.tableHeaderView = nil;
               [_self.yunzijiTableView reloadData];
           }
           [_self.yunzijiTableView.header endRefreshing];
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"韵字集";
    [self initToCollectionBarBtn];
    [self initYunzijiViewModel];
    [self initYunzijiTableView];
    [self.yunzijiTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yunzijiVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YunzijiCell *cell = [tableView dequeueReusableCellWithIdentifier:kYunzijiTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.descImageView setImageWithURL:[NSURL URLWithString:[self.yunzijiVM getTypeImgForRow:indexPath.row]] placeholderImage:nil];
    cell.titleLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeNameForRow:indexPath.row]];
    cell.descLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeDetailForRow:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *titleDic = @{NSFontAttributeName: [UIFont boldFlatFontOfSize:18]};
    NSDictionary *descDic = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGFloat labelConstraintWidth = self.view.frame.size.width - 80 - 30;
    CGSize titleSize = [[ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeNameForRow:indexPath.row]] boundingRectWithSize:CGSizeMake(labelConstraintWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleDic context:nil].size;
    CGSize descSize = [[ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeDetailForRow:indexPath.row]] boundingRectWithSize:CGSizeMake(labelConstraintWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:descDic context:nil].size;
        return 10 + titleSize.height + 5 + descSize.height + 10 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChineseRhymeViewController *chineseRhymeVC = [[ChineseRhymeViewController alloc] initChineseRhymeViewControllerWithTypeID:[self.yunzijiVM getTypeIDForRow:indexPath.row] TypeName:[ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeNameForRow:indexPath.row]]];
    [self.navigationController pushViewController:chineseRhymeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.yunzijiTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.yunzijiVM getTypeNameForRow:self.peekIndexPath.row];
    self.peekViewController = [[ChineseRhymeViewController alloc] initChineseRhymeViewControllerWithTypeID:[self.yunzijiVM getTypeIDForRow:self.peekIndexPath.row] TypeName:[ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeNameForRow:self.peekIndexPath.row]]];
    self.peekHeadLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.yunzijiVM getTypeNameForRow:self.peekIndexPath.row]];
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
