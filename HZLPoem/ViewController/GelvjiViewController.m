//
//  GelvjiViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GelvjiViewController.h"
#import "GelvjiViewModel.h"
#import "ToolClass.h"
#import "GelvjiDetailViewController.h"


#define kGelvjiTableViewCellIdentifier  @"gelvjiTableViewCell"

@interface GelvjiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *gelvjiTableView;
@property (nonatomic, strong) GelvjiViewModel *gelvjiVM;

@end

@implementation GelvjiViewController

- (void)initGelvjiVM {
    self.gelvjiVM = [[GelvjiViewModel alloc] init];
}

- (void)initPoemsTableViewHeadView {
    self.poemsTableViewHeadView = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 188 + 20) PoemImageName:@"gelvtableviewheadviewimage" BackgroundColor:kRGBColor(55, 55, 55) JianjieLabelText:@"   格律，指一系列中国古代诗歌独有的，在创作时的格式、音律等方面所应遵守的准则。中国古代近体诗、词在格律上要求严格，其他如古体诗、现代诗歌、欧化诗歌等没有确定的、严格的格律要求。"];
}

- (void)initGelvjiTableView {
    self.gelvjiTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.gelvjiTableView.delegate = self;
    self.gelvjiTableView.dataSource = self;
    self.gelvjiTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.gelvjiTableView];
    [self.gelvjiTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.gelvjiTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kGelvjiTableViewCellIdentifier];
    __weak typeof(self) _self = self;
    self.gelvjiTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_self.gelvjiVM refreshDataCompletionHandle:^(NSError *error) {
            if (error) {
                _self.gelvjiTableView.tableHeaderView = _self.noSearchResultView;
            } else {
                [_self.noSearchResultView removeFromSuperview];
                _self.gelvjiTableView.tableHeaderView = _self.poemsTableViewHeadView;
                [_self.gelvjiTableView reloadData];
            }
            [_self.gelvjiTableView.header endRefreshing];
        }];
    }];
    self.gelvjiTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_self.gelvjiVM getMoreDataCompletionHandle:^(NSError *error) {
            if (error) {
                [_self showErrorMsg:error.localizedDescription];
                [_self.gelvjiTableView.footer endRefreshing];
            } else {
                if (_self.gelvjiVM.isHasMore) {
                    [_self.gelvjiTableView reloadData];
                    [_self.gelvjiTableView.footer endRefreshing];
                } else {
                    [_self.gelvjiTableView.footer endRefreshingWithNoMoreData];
                }
            }
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"格律集";
    [self initToCollectionBarBtn];
    [self initGelvjiVM];
    [self initPoemsTableViewHeadView];
    [self initGelvjiTableView];
    [self.gelvjiTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gelvjiVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kGelvjiTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getNameForRow:indexPath.row]];
    cell.detailTextLabel.text = [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getNameDetailForRow:indexPath.row]];
    cell.textLabel.font = [UIFont boldFlatFontOfSize:18];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GelvjiDetailViewController *gelvjiDetailVC = [[GelvjiDetailViewController alloc] initGelvjiDetailViewControllerWithName:[self.gelvjiVM getNameForRow:indexPath.row] NameDetail:
                                                  [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getNameDetailForRow:indexPath.row]] Intro:
                                                  [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getIntroForRow:indexPath.row]] Sample:
                                                  [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getSampleForRow:indexPath.row]] MelodyNote:
                                                  [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getMelodyNoteForRow:indexPath.row]]];
    [self.navigationController pushViewController:gelvjiDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.gelvjiTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.gelvjiVM getNameForRow:self.peekIndexPath.row];
    self.peekViewController = [[GelvjiDetailViewController alloc] initGelvjiDetailViewControllerWithName:
                               [self.gelvjiVM getNameForRow:self.peekIndexPath.row] NameDetail:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getNameDetailForRow:self.peekIndexPath.row]] Intro:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getIntroForRow:self.peekIndexPath.row]] Sample:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getSampleForRow:self.peekIndexPath.row]] MelodyNote:
                               [ToolClass unsimplifiedExchangeToSimplified:[self.gelvjiVM getMelodyNoteForRow:self.peekIndexPath.row]]];
    [self.peekViewController.view addSubview:self.peekHeadLabel];
    [self.peekHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.peekViewController.view);
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
