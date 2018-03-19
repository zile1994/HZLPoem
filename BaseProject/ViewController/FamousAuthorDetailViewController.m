//
//  FamousAuthorDetailViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "FamousAuthorDetailViewController.h"
#import "AuthorDetailViewModel.h"
#import "FamousAuthorDetailHeadView.h"
#import "FamousAuthorZiLiaoViewController.h"
#import "NoDetailInformationCell.h"
#import "SearchAuthorAllPoemListViewController.h"
#import "NoSearchResultView.h"
#import "SectionHeadView.h"


#define kJianjieLabelFont  14
#define kAuthorImageWidth  75
#define kAuthorImageViewTopLeftOffset  15
#define kJianjieLabelOffSetWithAuthorImageView  15
#define kJIanjieLabelRightOffset  -15
#define kFamousAuthorDetailTableViewCellIdentifier  @"detailTableViewCell"
#define kFamousAuthorDetailTableViewSectionHeaderFooterViewIdentifier  @"famousAuthorDetailTableViewSectionHeaderView"

@interface FamousAuthorDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AuthorDetailViewModel *authorDetailVM;
@property (nonatomic, strong) UITableView *famousAuthorDetailTableView;
@property (nonatomic, strong) FamousAuthorDetailHeadView *detailHeadView;
@property (nonatomic, strong) UIBarButtonItem *searchAllPoem;
@property (nonatomic, strong) NoSearchResultView *noAuthorZiliaoView;

@end

@implementation FamousAuthorDetailViewController

- (id)initAuthorDetailViewControllrtWithAuthorName:(NSString *)authorName {
    if (self = [super init]) {
        self.authorName = authorName;
    }
    return self;
}

- (id)initAuthorDetailViewControllrtWithAuthorId:(NSString *)authorId AuthorName:(NSString *)authorName {
    if (self = [super init]) {
        self.authorId = authorId;
        self.authorName = authorName;
    }
    return self;
}

- (void)initFamousAuthorDatailVM {
    if (self.authorName) {
        _authorDetailVM = [[AuthorDetailViewModel alloc] initAuthorDetailViewModelWithAuthorName:self.authorName];
    }
    if (self.authorId) {
        _authorDetailVM = [[AuthorDetailViewModel alloc] initAuthorDetailViewModelWithAuthorId:self.authorId];
    }
    else {
    }
}

- (void)initfamousAuthorDatailTableView {
    self.famousAuthorDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.famousAuthorDetailTableView.delegate = self;
    self.famousAuthorDetailTableView.dataSource = self;
    [self.view addSubview:self.famousAuthorDetailTableView];
    [self.famousAuthorDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.famousAuthorDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFamousAuthorDetailTableViewCellIdentifier];
    [self.famousAuthorDetailTableView registerClass:[SectionHeadView class] forHeaderFooterViewReuseIdentifier:kFamousAuthorDetailTableViewSectionHeaderFooterViewIdentifier];
    __weak __typeof(self) _self = self;
    self.famousAuthorDetailTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.authorDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
           if (error) {
               [_self showErrorMsg:error.localizedDescription];
               _self.famousAuthorDetailTableView.tableFooterView = [UIView new];
           } else {
                   [_self.noSearchResultView removeFromSuperview];
                   [_self.detailHeadView.authorImageView setImageWithURL:[NSURL URLWithString:_self.authorDetailVM.authorDetailModel.icon] placeholderImage:[UIImage imageNamed:@"noauthorimage"]];
                   _self.detailHeadView.authorLabel.text = _self.authorDetailVM.authorDetailModel.author;
                   _self.detailHeadView.jianjieLabel.text = _self.authorDetailVM.authorDetailModel.jianjie;
                   [_self.detailHeadView sizeToFit];
                   _self.famousAuthorDetailTableView.tableHeaderView = _self.detailHeadView;
                   if (_self.authorDetailVM.rowNumber == 0) {
                       _self.famousAuthorDetailTableView.tableFooterView = _self.noAuthorZiliaoView;
                   } else {
                       [_self.noAuthorZiliaoView removeFromSuperview];
                       _self.famousAuthorDetailTableView.tableFooterView = [UIView new];
                   }
               [_self.famousAuthorDetailTableView reloadData];
           }
           [self.famousAuthorDetailTableView.header endRefreshing];
       }];
    }];
}

- (void)initDetailHeadView {
    self.detailHeadView = [[FamousAuthorDetailHeadView alloc] init];
    self.detailHeadView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    [self.view addSubview:self.detailHeadView];
}

- (void)initNoAuthorZiliaoView {
    self.noAuthorZiliaoView = [[NoSearchResultView alloc] init];
    self.noAuthorZiliaoView.backgroundColor = [UIColor clearColor];
    self.noAuthorZiliaoView.frame = CGRectMake(0, 100, self.view.frame.size.width, 50);
    self.noAuthorZiliaoView.noResultLabel.backgroundColor = [UIColor whiteColor];
    self.noAuthorZiliaoView.noResultLabel.text = @"暂无该作者详细资料";
}

- (void)initSearchAllPoem {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:@"全集" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(searchAllPoemList) forControlEvents:UIControlEventTouchUpInside];
    self.searchAllPoem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = self.searchAllPoem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.authorName;
    [self initFamousAuthorDatailVM];
    [self initNoAuthorZiliaoView];
    [self initfamousAuthorDatailTableView];
    [self initDetailHeadView];
    [self initSearchAllPoem];
    [self.famousAuthorDetailTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)searchAllPoemList {
    SearchAuthorAllPoemListViewController *searchAuthorAllPoemListVC = [[SearchAuthorAllPoemListViewController alloc] initSearchAuthorAllPoemListViewControllerWithAuthorName:self.authorName];
    [self.navigationController pushViewController:searchAuthorAllPoemListVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.authorDetailVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kFamousAuthorDetailTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.authorDetailVM ziliaoModelTitleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.authorDetailVM ziliaoModelWriteForRow:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kFamousAuthorDetailTableViewSectionHeaderFooterViewIdentifier];
    sectionHeadView.titleLabel.text = @"相关资料";
    return sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FamousAuthorZiLiaoViewController *ziliaoVC = [[FamousAuthorZiLiaoViewController alloc] initFamousAuthorZilLiaoViewControllerWithZlid:
                                                  [self.authorDetailVM ziliaoModelZlidForRow:indexPath.row] ziliaoTitlt:
                                                  [self.authorDetailVM ziliaoModelTitleForRow:indexPath.row]];
    [self.navigationController pushViewController:ziliaoVC animated:YES];
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
