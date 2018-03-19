//
//  ChuciViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChuciViewController.h"
#import "ChuciViewModel.h"
#import "PoemDetailViewController.h"
#import "NoSearchResultView.h"
#import "PoemsTableViewHeadView.h"
#import "ToolClass.h"


#define kChuciTableViewCellIdentifier  @"chuciTableViewCell"
#define kCellTextLabelFont  15
#define kCellDetailLabelFont  17


@interface ChuciViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ChuciViewModel *chuciVM;
@property (nonatomic, strong) UITableView *chuciTableView;
@property (nonatomic, strong) PoemsTableViewHeadView *poemsTableViewHV;

@end

@implementation ChuciViewController

- (void)initChuciModel {
    self.chuciVM = [[ChuciViewModel alloc] init];
}

- (void)initChuciTableView {
    self.chuciTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.chuciTableView.delegate = self;
    self.chuciTableView.dataSource = self;
    self.poemsTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 188 + 20)
                                                        PoemImageName:@"chuciheadview"
                                                      BackgroundColor:kRGBColor(55, 55, 55)
                                                     JianjieLabelText:@"    楚辞是屈原创作的一种新诗体，并且也是中国文学史上第一部浪漫主义诗歌总集。《楚辞》对整个中国文化系统有不同寻常的意义，特别是文学方面，它开创了中国浪漫主义文学的诗篇，令后世因称此种文,而四大体裁诗歌、小说、散文、戏剧皆不同程度存在其身影。"];
    self.chuciTableView.tableFooterView = [UIView new];
    self.chuciTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.chuciTableView.sectionIndexColor = [UIColor redColor];
    [self.view addSubview:self.chuciTableView];
    [self.chuciTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.chuciTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kChuciTableViewCellIdentifier];
    __weak __typeof(self) _self = self;
    self.chuciTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.chuciVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.chuciTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.chuciTableView.tableHeaderView = _self.poemsTableViewHV;
               [_self.chuciTableView reloadData];
           }
           [_self.chuciTableView.header endRefreshing];
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"楚辞";
    [self initToCollectionPoemBarBtn];
    [self initChuciModel];
    [self initChuciTableView];
    [self.chuciTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chuciVM.rowNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chuciVM numberCellsForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kChuciTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:kCellTextLabelFont];
    cell.detailTextLabel.font = [UIFont boldFlatFontOfSize:kCellDetailLabelFont];
    cell.textLabel.text = [self.chuciVM getAuthorForSection:indexPath.section Row:indexPath.row];
    cell.detailTextLabel.text = [self.chuciVM getTitleForSection:indexPath.section Row:indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                                              [self.chuciVM getIdForSection:indexPath.section Row:indexPath.row] PoemTitle:
                                              [self.chuciVM getTitleForSection:indexPath.section Row:indexPath.row] AuthorName:
                                              [self.chuciVM getAuthorForSection:indexPath.section Row:indexPath.row]];
    [self.navigationController pushViewController:poemDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.chuciTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.chuciVM getTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.chuciVM getIdForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] PoemTitle:
                               [self.chuciVM getTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] AuthorName:
                               [self.chuciVM getAuthorForSection:self.peekIndexPath.section Row:self.peekIndexPath.row]];
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
