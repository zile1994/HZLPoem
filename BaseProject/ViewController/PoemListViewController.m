//
//  PoemListViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemListViewController.h"
#import "PoemViewModel.h"
#import "PoemListCell.h"
#import "UIImageView+WebCache.h"
#import "PoemDetailViewController.h"
#import "SelectedButton.h"
#import "NoSearchResultView.h"
#import "ToolClass.h"


#define kPoemListTableViewCellIdentifier  @"poemListCell"
#define kSelectTableViewCellIdentifier  @"selectedCell"
#define kPoemListTableViewCellHeight  100
#define kHeadViewHeight  40
#define kHeadViewTopOffsetWithSelfView  64
#define kLineViewWidth 2
#define kLineViewHeight  30
#define kTextfiledFont  18
#define kTouchViewCornerRadius  7
#define kButtonTablViewWidth  self.view.frame.size.width / 3
#define kSelectedTableViewHeight  self.view.frame.size.height / 3
#define kTouchViewHeight  self.view.frame.size.height / 3
#define kTouchBackgroundColor  [UIColor colorWithWhite:0.9 alpha:1.0]
#define kAnimationTime  0.3
#define kDelayAnimation  0.0
extern NSString * const TouchCollectionOtherViewControllerToTabBar;
extern NSString * const TouchFamousAuthorAndSearchViewControllerPopToTabBar;


@interface PoemListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *poemListTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) PoemViewModel *poemVM;
@property (nonatomic, strong) NSString *leixing;
@property (nonatomic, strong) NSString *chaodai;
@property (nonatomic, strong) NSString *xingshi;
@property (nonatomic, strong) NSArray *leixingArr;
@property (nonatomic, strong) NSArray *chaodaiArr;
@property (nonatomic, strong) NSArray *xingshiArr;
@property (nonatomic, strong) UIView *firstLineView;
@property (nonatomic, strong) UIView *secondLineView;
@property (nonatomic, strong) SelectedButton *leixingButton;
@property (nonatomic, strong) SelectedButton *chaodaiButton;
@property (nonatomic, strong) SelectedButton *xingshiButton;
@property (nonatomic, strong) UIView *leixingTouchView;
@property (nonatomic, strong) UITableView *leixingTableView;
@property (nonatomic, strong) UIView *chaodaiTouchView;
@property (nonatomic, strong) UITableView *chaodaiTableView;
@property (nonatomic, strong) UIView *xingshiTouchView;
@property (nonatomic, strong) UITableView *xingshiTableView;

@end

@implementation PoemListViewController

- (void)initLeixingArr {
    self.leixingArr = @[@"类型", @"写景", @"咏物", @"春天", @"夏天", @"秋天", @"冬天", @"写雨", @"写雪", @"写风", @"写花", @"梅花", @"荷花", @"菊花", @"柳树", @"月亮", @"山水", @"写山", @"写水", @"长江", @"黄河", @"儿童", @"写鸟", @"写马", @"田园", @"边塞", @"地名", @"抒情", @"爱国", @"离别", @"送别", @"思乡", @"思念", @"爱情", @"励志", @"哲理", @"闺怨", @"悼亡", @"写人", @"老师", @"母亲", @"友情", @"战争", @"读书", @"惜时", @"婉约", @"豪放", @"诗经", @"民谣", @"节日", @"春节", @"元宵节", @"寒食节", @"清明节", @"端午节", @"七夕节", @"中秋节", @"重阳"];
}

- (void)initChaodaiArr {
    self.chaodaiArr = @[@"朝代", @"先秦", @"两汉", @"魏晋", @"南北朝", @"隋代", @"唐代", @"五代", @"宋辽金", @"元代", @"明代", @"清代"];
}

- (void)initXingshiArr {
    self.xingshiArr = @[@"形式", @"诗", @"词", @"曲", @"文言文", @"辞赋"];
}

- (SelectedButton *)setButton {
    SelectedButton *button = [SelectedButton buttonWithType:UIButtonTypeCustom];
    button.isSelecting = NO;
    button.selected = NO;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    return button;
}

- (void)initHeadView {
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = kRGBColor(255, 255, 255);
    self.headView.layer.shadowOpacity = 0.5;
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kHeadViewHeight);
    }];
    self.leixingButton = [self setButton];
    [self.leixingButton setTitle:self.leixingArr[0] forState:UIControlStateNormal];
    [self.leixingButton addTarget:self action:@selector(selectLeixing) forControlEvents:UIControlEventTouchUpInside];
    self.chaodaiButton = [self setButton];
    [self.chaodaiButton setTitle:self.chaodaiArr[0] forState:UIControlStateNormal];
    [self.chaodaiButton addTarget:self action:@selector(selectChaodai) forControlEvents:UIControlEventTouchUpInside];
    self.xingshiButton = [self setButton];
    [self.xingshiButton setTitle:self.xingshiArr[0] forState:UIControlStateNormal];
    [self.xingshiButton addTarget:self action:@selector(selectXingshi) forControlEvents:UIControlEventTouchUpInside];
    self.firstLineView = [[UIView alloc] init];
    self.firstLineView.backgroundColor = [UIColor whiteColor];
    self.secondLineView = [[UIView alloc] init];
    self.secondLineView.backgroundColor = [UIColor whiteColor];
    
    [self.headView addSubview:self.leixingButton];
    [self.leixingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headView);
        make.width.mas_equalTo((self.view.frame.size.width - 2 * kLineViewWidth) / 3.0);
    }];
    [self.headView addSubview:self.firstLineView];
    [self.firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leixingButton.mas_right);
        make.centerY.mas_equalTo(self.headView);
        make.size.mas_equalTo(CGSizeMake(kLineViewWidth, kLineViewHeight));
    }];
    [self.headView addSubview:self.chaodaiButton];
    [self.chaodaiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstLineView.mas_right);
        make.width.mas_equalTo(self.leixingButton);
        make.centerY.mas_equalTo(self.headView);
    }];
    [self.headView addSubview:self.secondLineView];
    [self.secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chaodaiButton.mas_right);
        make.centerY.mas_equalTo(self.headView);
        make.size.mas_equalTo(self.firstLineView);
    }];
    [self.headView addSubview:self.xingshiButton];
    [self.xingshiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.secondLineView.mas_right);
        make.width.mas_equalTo(self.leixingButton);
        make.centerY.mas_equalTo(self.headView);
    }];
    self.leixing = self.leixingArr[0];
    self.chaodai = self.chaodaiArr[0];
    self.xingshi = self.xingshiArr[0];
}

- (UIView *)setTouchView {
    UIView *touchView = [[UIView alloc] init];
    touchView.layer.cornerRadius = kTouchViewCornerRadius;
    touchView.layer.masksToBounds = YES;
    touchView.backgroundColor = kRGBColor(255, 255, 255);
    touchView.layer.borderWidth = 1.5;
    touchView.layer.borderColor = [[UIColor blackColor] CGColor];
    touchView.layer.shadowOpacity = 0.5;
    touchView.layer.shadowColor = [UIColor blackColor].CGColor;
    touchView.layer.shadowOffset = CGSizeMake(3, 3);
    touchView.layer.masksToBounds = NO;
    touchView.layer.shadowRadius = 5;
    [self.view addSubview:touchView];
    return touchView;
}

- (UITableView *)setTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    return tableView;
}

#pragma mark TouchView and TableView init method

- (void)initLeixingTouchView {
    self.leixingTouchView = [self setTouchView];
    self.leixingTouchView.frame = CGRectMake(0, kHeadViewHeight, kButtonTablViewWidth, 0);
}

- (void)initLeixingTableView {
    self.leixingTableView = [self setTableView];
    [self.leixingTouchView addSubview:self.leixingTableView];
    self.leixingTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, 0);
    [self.leixingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSelectTableViewCellIdentifier];
    self.leixingTouchView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.leixingTableView.frame].CGPath;
}

- (void)initChaodaiTouchView {
    self.chaodaiTouchView = [self setTouchView];
    self.chaodaiTouchView.frame = CGRectMake(kButtonTablViewWidth, kHeadViewHeight, kButtonTablViewWidth, 0);
}

- (void)initChaodaiTableView {
    self.chaodaiTableView = [self setTableView];
    [self.chaodaiTouchView addSubview:self.chaodaiTableView];
    self.chaodaiTableView.frame = CGRectMake(kLineViewWidth, 0, kButtonTablViewWidth, 0);
    [self.chaodaiTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSelectTableViewCellIdentifier];
    self.chaodaiTouchView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.chaodaiTableView.frame].CGPath;
}

- (void)initXingshiTouchView {
    self.xingshiTouchView = [self setTouchView];
    self.xingshiTouchView.frame = CGRectMake(kButtonTablViewWidth * 2, kHeadViewHeight, kButtonTablViewWidth, 0);
}

- (void)initXingshiTablView {
    self.xingshiTableView = [self setTableView];
    [self.xingshiTouchView addSubview:self.xingshiTableView];
    self.xingshiTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, 0);
    [self.xingshiTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSelectTableViewCellIdentifier];
    self.xingshiTouchView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.xingshiTableView.frame].CGPath;
}

#pragma mark the animation of TouchView and TableView's
- (void)openLeixingTouchViewAndTableViewWithAnimation {
    self.leixingButton.selected = YES;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.leixingTouchView.frame = CGRectMake(0, kHeadViewHeight, kButtonTablViewWidth, kTouchViewHeight);
        self.leixingTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, kSelectedTableViewHeight);
    } completion:^(BOOL finished) {
        self.leixingButton.isSelecting = YES;
    }];
}

- (void)openChaodaiTouchViewAndTableViewWithAnimation {
    self.chaodaiButton.selected = YES;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.chaodaiTouchView.frame = CGRectMake(kButtonTablViewWidth, kHeadViewHeight, kButtonTablViewWidth, kTouchViewHeight);
        self.chaodaiTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, kSelectedTableViewHeight);
    } completion:^(BOOL finished) {
        self.chaodaiButton.isSelecting = YES;
    }];
}

- (void)openXingshiTouchViewAndTableViewWithAnimation {
    self.xingshiButton.selected = YES;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.xingshiTouchView.frame = CGRectMake(2 * kButtonTablViewWidth, kHeadViewHeight, kButtonTablViewWidth, kTouchViewHeight);
        self.xingshiTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, kSelectedTableViewHeight);
    } completion:^(BOOL finished) {
        self.xingshiButton.isSelecting = YES;
    }];
}

- (void)closeLeixingTouchViewAndTableViewWithAnimation {
    self.leixingButton.selected = NO;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.leixingTouchView.frame = CGRectMake(0, kHeadViewHeight, kButtonTablViewWidth, 0);
        self.leixingTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, 0);
    } completion:^(BOOL finished) {
        self.leixingButton.isSelecting = NO;
    }];
}

- (void)closeChaodaiTouchViewAndTableViewWithAnimation {
    self.chaodaiButton.selected = NO;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.chaodaiTouchView.frame = CGRectMake(kButtonTablViewWidth, kHeadViewHeight, kButtonTablViewWidth, 0);
        self.chaodaiTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, 0);
    } completion:^(BOOL finished) {
        self.chaodaiButton.isSelecting = NO;
    }];
}

- (void)closeXingshiTouchViewAndTableViewWithAnimation {
    self.xingshiButton.selected = NO;
    [UIView animateWithDuration:kAnimationTime delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.xingshiTouchView.frame = CGRectMake(kButtonTablViewWidth * 2, kHeadViewHeight, kButtonTablViewWidth, 0);
        self.xingshiTableView.frame = CGRectMake(0, 0, kButtonTablViewWidth, 0);
    } completion:^(BOOL finished) {
        self.xingshiButton.isSelecting = NO;
    }];
}

- (void)selectLeixing {
    if (!self.leixingButton.isSelecting) {
        [self openLeixingTouchViewAndTableViewWithAnimation];
        [self closeChaodaiTouchViewAndTableViewWithAnimation];
        [self closeXingshiTouchViewAndTableViewWithAnimation];
    } else {
        [self closeLeixingTouchViewAndTableViewWithAnimation];
    }
}

- (void)selectChaodai {
    if (!self.chaodaiButton.isSelecting) {
        [self closeLeixingTouchViewAndTableViewWithAnimation];
        [self closeXingshiTouchViewAndTableViewWithAnimation];
        [self openChaodaiTouchViewAndTableViewWithAnimation];
    } else {
        [self closeChaodaiTouchViewAndTableViewWithAnimation];
    }
}

- (void)selectXingshi {
    if (!self.xingshiButton.isSelecting) {
        [self closeLeixingTouchViewAndTableViewWithAnimation];
        [self closeChaodaiTouchViewAndTableViewWithAnimation];
        [self openXingshiTouchViewAndTableViewWithAnimation];
    } else {
        [self closeXingshiTouchViewAndTableViewWithAnimation];
    }
}

- (void)initPoemVM {
    if ([self.leixing isEqualToString:@"类型"]) {
        self.leixing = @"";
    }
    if ([self.chaodai isEqualToString:@"朝代"]) {
        self.chaodai = @"";
    }
    if ([self.xingshi isEqualToString:@"形式"]) {
        self.xingshi = @"";
    }
    self.poemVM = [[PoemViewModel alloc] initPoemViewModelWithLeixing:self.leixing Chaodai:self.chaodai Xingshi:self.xingshi];
}

- (void)initNoResultOfSearchView {
    [super initNoResultOfSearchView];
    self.noResultOfSearchView.noResultOfSearchLabel.text = @"没有符合条件的作品";
}

/**初始化UITableView 视图展示诗文列表*/
- (void)initPoemListTableView {
    self.poemListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.poemListTableView.delegate = self;
    self.poemListTableView.dataSource = self;
    self.poemListTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.poemListTableView];
    [self.poemListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
    }];
    [self.poemListTableView registerClass:[PoemListCell class] forCellReuseIdentifier:kPoemListTableViewCellIdentifier];
    __weak __typeof(self) _self = self;
    
    /**用户下拉刷新数据以及上拉加载更多，以及对于网络请求错误处理*/
    self.poemListTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.poemVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.poemListTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               if (self.poemVM.rowNumber == 0) {
                   _self.poemListTableView.tableHeaderView = _self.noResultOfSearchView;
               } else {
                   [_self.noResultOfSearchView removeFromSuperview];
                   [_self.noSearchResultView removeFromSuperview];
                   _self.poemListTableView.tableHeaderView = nil;
                   [_self.poemListTableView reloadData];
               }
           }
           [_self.poemListTableView.header endRefreshing];
       }];
    }];
    self.poemListTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [_self.poemVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [_self showErrorMsg:error.localizedDescription];
                    [_self.poemListTableView.footer endRefreshing];
                } else {
                    [_self.poemListTableView reloadData];
                    if (_self.poemVM.hasMore) {
                        [_self.poemListTableView.footer endRefreshing];
                    } else {
                        [_self.poemListTableView.footer endRefreshingWithNoMoreData];
                    }
                }
            }];
        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"古诗文";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLeixingArr];
    [self initXingshiArr];
    [self initChaodaiArr];
    [self initHeadView];
    [self initPoemVM];
    [self initNoResultOfSearchView];
    [self initPoemListTableView];
    [self initLeixingTouchView];
    [self initLeixingTableView];
    [self initChaodaiTouchView];
    [self initChaodaiTableView];
    [self initXingshiTouchView];
    [self initXingshiTablView];
    [self initNoSearchResultView];
    [self.poemListTableView.header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToTabBar) name:TouchCollectionOtherViewControllerToTabBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToTabBar) name:TouchFamousAuthorAndSearchViewControllerPopToTabBar object:nil];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)popToTabBar {
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[PoemListViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self closeLeixingTouchViewAndTableViewWithAnimation];
    [self closeChaodaiTouchViewAndTableViewWithAnimation];
    [self closeXingshiTouchViewAndTableViewWithAnimation];
}

#pragma mark tableView's method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.poemListTableView) {
        return self.poemVM.rowNumber;
    } else if (tableView == self.leixingTableView) {
        return self.leixingArr.count;
    } else if (tableView == self.chaodaiTableView) {
        return self.chaodaiArr.count;
    } else if (tableView == self.xingshiTableView){
        return self.xingshiArr.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.poemListTableView) {
        PoemListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPoemListTableViewCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.authorImageView  sd_setImageWithURL:[self.poemVM authorPicURLWithIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"noauthorimage"]];
        cell.authorLabel.text = [self.poemVM authorWithIndex:indexPath.row];
        cell.titleLabel.text = [self.poemVM titleWithIndex:indexPath.row];
        cell.strViewsLabel.text = [NSString stringWithFormat:@"%@分(%@人评价)  浏览次数:%@", [self.poemVM starWithIndex:indexPath.row], [self.poemVM starCountWithIndex:indexPath.row], [self.poemVM viewsWithIndex:indexPath.row]];
        cell.formDynastyLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [self.poemVM xingshiWithIndex:indexPath.row], [self.poemVM chaodaiWithIndex:indexPath.row], [self.poemVM leixingWithIndex:indexPath.row]];
        cell.yuanwenLabel.text = [self.poemVM yuanwenWithIndex:indexPath.row];
        return cell;
    } else {
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectTableViewCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kRGBColor(255, 255, 255);
        cell.textLabel.textColor = kRGBColor(200, 100, 100);
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        if (tableView == self.leixingTableView) {
            cell.textLabel.text = self.leixingArr[indexPath.row];
        } else if (tableView == self.chaodaiTableView) {
            cell.textLabel.text = self.chaodaiArr[indexPath.row];
        } else if (tableView == self.xingshiTableView){
            cell.textLabel.text = self.xingshiArr[indexPath.row];
        } else {
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.poemListTableView) {
        return kPoemListTableViewCellHeight;
    } else {
        return 35;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.poemListTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self closeLeixingTouchViewAndTableViewWithAnimation];
        [self closeXingshiTouchViewAndTableViewWithAnimation];
        [self closeChaodaiTouchViewAndTableViewWithAnimation];
        PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                                                  [self.poemVM viewidWithIndex:indexPath.row] PoemTitle:
                                                  [self.poemVM titleWithIndex:indexPath.row] AuthorId:
                                                  [self.poemVM authorIdWithIndex:indexPath.row] AuthorName:
                                                  [self.poemVM authorWithIndex:indexPath.row]];
        [poemDetailVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:poemDetailVC animated:YES];
    } else {
        if (tableView == self.leixingTableView) {
            NSString *leixingButtonStr = [self.leixingButton titleForState:UIControlStateNormal];
            if ([leixingButtonStr isEqualToString:self.leixingArr[indexPath.row]]) {
                [self closeLeixingTouchViewAndTableViewWithAnimation];
                return;
            } else {
                [self.leixingButton setTitle:self.leixingArr[indexPath.row] forState:UIControlStateNormal];
                self.leixing = self.leixingArr[indexPath.row];
                [self closeLeixingTouchViewAndTableViewWithAnimation];
            }
        } else if (tableView == self.chaodaiTableView) {
            NSString *chaodaiButtonStr = [self.chaodaiButton titleForState:UIControlStateNormal];
            if ([chaodaiButtonStr isEqualToString:self.chaodaiArr[indexPath.row]]) {
                [self closeChaodaiTouchViewAndTableViewWithAnimation];
                return;
            } else {
                [self.chaodaiButton setTitle:self.chaodaiArr[indexPath.row] forState:UIControlStateNormal];
                self.chaodai = self.chaodaiArr[indexPath.row];
                [self closeChaodaiTouchViewAndTableViewWithAnimation];
            }
        } else if (tableView == self.xingshiTableView){
            NSString *xingshiButtonStr = [self.xingshiButton titleForState:UIControlStateNormal];
            if ([xingshiButtonStr isEqualToString:self.xingshiArr[indexPath.row]]) {
                [self closeXingshiTouchViewAndTableViewWithAnimation];
                return;
            } else {
                [self.xingshiButton setTitle:self.xingshiArr[indexPath.row] forState:UIControlStateNormal];
                self.xingshi = self.xingshiArr[indexPath.row];
                [self closeXingshiTouchViewAndTableViewWithAnimation];
            }
        } else {
        }
        [self initPoemVM];
        [self.poemListTableView.header beginRefreshing];
        [self.poemListTableView reloadData];
    }
}

#pragma mark Peek's method

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.poemListTableView previewingContext:previewingContext Location:location];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.poemVM viewidWithIndex:self.peekIndexPath.row] PoemTitle:
                               [self.poemVM titleWithIndex:self.peekIndexPath.row] AuthorId:
                               [self.poemVM authorIdWithIndex:self.peekIndexPath.row] AuthorName:
                               [self.poemVM authorWithIndex:self.peekIndexPath.row]];
    self.peekHeadLabel = [ToolClass setPeekHeadLabelWithTitle:
                          [self.poemVM titleWithIndex:self.peekIndexPath.row] BackgroundColor:
                          kRGBColor(214, 0, 6) TitltColor:
                          [UIColor whiteColor]];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.poemListTableView) {
        [self closeLeixingTouchViewAndTableViewWithAnimation];
        [self closeChaodaiTouchViewAndTableViewWithAnimation];
        [self closeXingshiTouchViewAndTableViewWithAnimation];
    }
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
