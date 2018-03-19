//
//  SearchAllAuthorViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SearchAllAuthorViewController.h"
#import "ChaodaiCollectionViewCell.h"
#import "SelectedButton.h"
#import "SearchAuthorViewModel.h"
#import "ChaodaiAuthorListCell.h"
#import "FamousAuthorDetailViewController.h"
#import "NoSearchResultView.h"
#import "ToolClass.h"


#define kSearchAllAuthorHeadViewHeight  40
#define kChaodaiCollectionViewCellIdentifier  @"chaodaiCollectionViewCell"
#define kChaodaiAuthorListTableViewCellIdentifier  @"chaodaiAuthorListTableViewCell"


@interface SearchAllAuthorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *chaodaiArr;
@property (nonatomic, strong) UIView *SearchAllAuthorHeadView;
@property (nonatomic, strong) UIButton *tangdaiBtn;
@property (nonatomic, strong) UIButton *songdaiBtn;
@property (nonatomic, strong) UIButton *changeChaodaiBtn;
@property (nonatomic, strong) SelectedButton *moreChaodaiBtn;
@property (nonatomic, strong) UICollectionView *chaodaiCollectionView;
@property (nonatomic, strong) UIView *chaodaiTouchView;
@property (nonatomic, strong) SearchAuthorViewModel *searchAuthorVM;
@property (nonatomic, strong) UITableView *chaodaiAuthorListTableView;
@property (nonatomic, strong) NSString *chaodai;


@end

@implementation SearchAllAuthorViewController

- (void)initChaodaiArr {
    self.chaodaiArr = @[@"先秦", @"秦", @"汉", @"三国", @"魏晋", @"隋代", @"五代", @"金代", @"元代", @"明代", @"清代", @"近代"];
}

- (void)initSearchAllAuthorHeadView {
    self.SearchAllAuthorHeadView = [[UIView alloc] init];
    self.SearchAllAuthorHeadView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.SearchAllAuthorHeadView];
    [self.SearchAllAuthorHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    self.tangdaiBtn = [self setButtonWithTitlt:@"唐代" BackgroundColor:kRGBColor(236, 236, 236) TitleColor:[UIColor blackColor] SelectedColor:kRGBColor(200, 100, 100)];
    self.songdaiBtn = [self setButtonWithTitlt:@"宋代" BackgroundColor:kRGBColor(236, 236, 236) TitleColor:[UIColor blackColor] SelectedColor:kRGBColor(200, 100, 100)];
    self.changeChaodaiBtn = [self setButtonWithTitlt:@"秦" BackgroundColor:kRGBColor(236, 236, 236) TitleColor:[UIColor blackColor] SelectedColor:kRGBColor(200, 100, 100)];
    
    self.moreChaodaiBtn = [SelectedButton buttonWithType:UIButtonTypeCustom];
    self.moreChaodaiBtn.isSelecting = NO;
    [self.moreChaodaiBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreChaodaiBtn setBackgroundColor:kRGBColor(236, 236, 236)];
    [self.moreChaodaiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.moreChaodaiBtn setTitleColor:kRGBColor(200, 100, 100) forState:UIControlStateSelected];
    
    [self.SearchAllAuthorHeadView addSubview:self.tangdaiBtn];
    [self.tangdaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self.SearchAllAuthorHeadView);
        make.width.mas_equalTo(kWidth / 4);
    }];
    [self.SearchAllAuthorHeadView addSubview:self.songdaiBtn];
    [self.songdaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tangdaiBtn.mas_right);
        make.size.mas_equalTo(self.tangdaiBtn);
    }];
    [self.SearchAllAuthorHeadView addSubview:self.changeChaodaiBtn];
    [self.changeChaodaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.songdaiBtn.mas_right);
        make.size.mas_equalTo(self.tangdaiBtn);
    }];
    [self.SearchAllAuthorHeadView addSubview:self.moreChaodaiBtn];
    [self.moreChaodaiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.changeChaodaiBtn.mas_right);
        make.top.right.bottom.mas_equalTo(self.SearchAllAuthorHeadView);
    }];
    [self.tangdaiBtn addTarget:self action:@selector(toSearchAuthor:) forControlEvents:UIControlEventTouchUpInside];
    [self.songdaiBtn addTarget:self action:@selector(toSearchAuthor:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeChaodaiBtn addTarget:self action:@selector(toSearchAuthor:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreChaodaiBtn addTarget:self action:@selector(toVisualChaodaiCollectionView) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)setButtonWithTitlt:(NSString *)title BackgroundColor:(UIColor *)backgroundColor TitleColor:(UIColor *)titleColor SelectedColor:(UIColor *)selectedColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backgroundColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    return btn;
}

- (void)toSearchAuthor: (UIButton *)sender {
    if (!sender.selected) {
        UIButton *button = sender;
        button.selected = YES;
        self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 0);
        self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 0);
        self.moreChaodaiBtn.isSelecting = NO;
        if (button == self.tangdaiBtn) {
            self.songdaiBtn.selected = NO;
            self.changeChaodaiBtn.selected = NO;
            self.moreChaodaiBtn.selected = NO;
        } else if (button == self.songdaiBtn) {
            self.tangdaiBtn.selected = NO;
            self.changeChaodaiBtn.selected = NO;
            self.moreChaodaiBtn.selected = NO;
        } else if (button == self.changeChaodaiBtn) {
            self.tangdaiBtn.selected = NO;
            self.songdaiBtn.selected = NO;
            self.moreChaodaiBtn.selected = NO;
        } else {
        }
        self.chaodai = [button titleForState:UIControlStateNormal];
        [self initSearchAuthorVM];
        [self.noSearchResultView removeFromSuperview];
        [self.searchAuthorVM.dataArr removeAllObjects];
        [self.chaodaiAuthorListTableView reloadData];
        [self.chaodaiAuthorListTableView.header beginRefreshing];
    } else {
    
    }
}

- (void)initChaodaiTouchView {
    self.chaodaiTouchView = [[UIView alloc] init];
    [self.view addSubview:self.chaodaiTouchView];
    self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 0);
}

- (void) initChaodaiCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kWidth / 4, 40);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    self.chaodaiCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.chaodaiCollectionView.delegate = self;
    self.chaodaiCollectionView.dataSource = self;
    self.chaodaiCollectionView.layer.cornerRadius = 5;
    self.chaodaiCollectionView.layer.masksToBounds = YES;
    self.chaodaiCollectionView.layer.borderWidth = 1;
    self.chaodaiCollectionView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.chaodaiCollectionView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    [self.chaodaiTouchView addSubview:self.chaodaiCollectionView];
    
    self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 0);
    self.chaodaiCollectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1);
    [self.chaodaiCollectionView registerClass:[ChaodaiCollectionViewCell class] forCellWithReuseIdentifier:kChaodaiCollectionViewCellIdentifier];
}

- (void)toVisualChaodaiCollectionView {
    self.moreChaodaiBtn.selected = YES;
    if (!self.moreChaodaiBtn.isSelecting) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 165);
            self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 165);
        } completion:^(BOOL finished) {
            self.moreChaodaiBtn.isSelecting = YES;
        }];
    } else {
        self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 0);
        self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 0);
        self.moreChaodaiBtn.isSelecting = NO;
        self.moreChaodaiBtn.selected = NO;
    }
}

- (void)initSearchAuthorVM {
    self.searchAuthorVM = [[SearchAuthorViewModel alloc] initSearchAuthorViewModelWithChaodai:self.chaodai];
}

- (void)initChaodaiAuthorListTableView {
    self.chaodaiAuthorListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.chaodaiAuthorListTableView.delegate = self;
    self.chaodaiAuthorListTableView.dataSource = self;
    [self.view addSubview:self.chaodaiAuthorListTableView];
    self.chaodaiAuthorListTableView.tableFooterView = [UIView new];
    [self.chaodaiAuthorListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.SearchAllAuthorHeadView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    [self.chaodaiAuthorListTableView registerClass:[ChaodaiAuthorListCell class] forCellReuseIdentifier:kChaodaiAuthorListTableViewCellIdentifier];
    __weak __typeof(self) _self = self;
    self.chaodaiAuthorListTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.searchAuthorVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
                _self.chaodaiAuthorListTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
                _self.chaodaiAuthorListTableView.tableHeaderView = nil;
               [_self.chaodaiAuthorListTableView reloadData];
           }
           [self.chaodaiAuthorListTableView.header endRefreshing];
       }];
    }];
    self.chaodaiAuthorListTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_self.searchAuthorVM getMoreDataCompletionHandle:^(NSError *error) {
            if (error) {
                [_self showErrorMsg:error.localizedDescription];
                [_self.chaodaiAuthorListTableView.footer endRefreshing];
            } else {
                [_self.chaodaiAuthorListTableView reloadData];
                if (self.searchAuthorVM.hasMore) {
                    [_self.chaodaiAuthorListTableView.footer endRefreshing];
                } else {
                    [_self.chaodaiAuthorListTableView.footer endRefreshingWithNoMoreData];
                }
            }
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部知名诗人";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initToCollectionAuthorBarBtn];
    [self initChaodaiArr];
    [self initSearchAllAuthorHeadView];
    self.chaodai = @"唐";
    self.tangdaiBtn.selected = YES;
    [self initSearchAuthorVM];
    [self initChaodaiAuthorListTableView];
    [self initChaodaiTouchView];
    [self initChaodaiCollectionView];
    [self.chaodaiAuthorListTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

#pragma mark chaodaiColltctionView's method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chaodaiArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChaodaiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChaodaiCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.chaodaiLabel.text = self.chaodaiArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.tangdaiBtn.selected = NO;
    self.songdaiBtn.selected = NO;
    self.moreChaodaiBtn.selected = NO;
    self.changeChaodaiBtn.selected = YES;
    self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 0);
    self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 0);
    self.moreChaodaiBtn.isSelecting = NO;
    if (![self.chaodai isEqualToString:self.chaodaiArr[indexPath.item]]) {
        [self.changeChaodaiBtn setTitle:self.chaodaiArr[indexPath.row] forState:UIControlStateNormal];
        self.chaodai = self.chaodaiArr[indexPath.item];
        [self initSearchAuthorVM];
        [self.searchAuthorVM.dataArr removeAllObjects];
        [self.chaodaiAuthorListTableView reloadData];
        [self.chaodaiAuthorListTableView.header beginRefreshing];
    }
}

- (void)closeChaodaiCollectionView {
    self.moreChaodaiBtn.selected = NO;
    self.moreChaodaiBtn.isSelecting = NO;
    self.chaodaiCollectionView.frame = CGRectMake(0, 0, kWidth * 3 / 4 + 4, 0);
    self.chaodaiTouchView.frame = CGRectMake((kWidth / 4) - 4, 40, kWidth * 3 / 4 + 4, 0);
}

#pragma mark ChaodaiAuthorListTableView's method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchAuthorVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChaodaiAuthorListCell *cell = [tableView dequeueReusableCellWithIdentifier:kChaodaiAuthorListTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.authorImageView setImageWithURL:[self.searchAuthorVM getIconForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"noauthorimage"]];
    cell.chaodaiLabel.text = [self.searchAuthorVM getChaodaiForRow:indexPath.row];
    cell.authorLabel.text = [self.searchAuthorVM getAuthorForRow:indexPath.row];
    NSString *views = [self.searchAuthorVM getViewsFoeRow:indexPath.row];
    cell.viewsLabel.text = [NSString stringWithFormat:@"浏览次数:%@", views];
    cell.jianjieLabel.text = [self.searchAuthorVM getJianjieForRow:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeChaodaiCollectionView];
    FamousAuthorDetailViewController *vc = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:[self.searchAuthorVM getAuthorForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.chaodaiAuthorListTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.searchAuthorVM getAuthorForRow:self.peekIndexPath.row];
    self.peekViewController = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:[self.searchAuthorVM getAuthorForRow:self.peekIndexPath.row]];
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
