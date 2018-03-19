//
//  ShijingViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ShijingViewController.h"
#import "ShijingViewModel.h"
#import "SectionHeadView.h"
#import "PoemDetailViewController.h"
#import "NoSearchResultView.h"
#import "PoemsTableViewHeadView.h"
#import "ToolClass.h"



#define kShijingTableViewCellIdentifier  @"shijingTableViewCell"
#define kShijianTableViewSectionHeadViewIdentifier  @"shijianTableViewSectionHeadView"

@interface ShijingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ShijingViewModel *shijingVM;
@property (nonatomic, strong) UITableView *shijingTableView;
@property (nonatomic, strong) PoemsTableViewHeadView *poemsTableViewHeadView;

@end

@implementation ShijingViewController

- (void)initShijingVM {
    self.shijingVM = [[ShijingViewModel alloc] init];
}

- (void)initShijingTableView {
    self.shijingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.shijingTableView.delegate = self;
    self.shijingTableView.dataSource = self;
    self.poemsTableViewHeadView = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 188 + 20)
                                                              PoemImageName:@"shijingheadview"
                                                            BackgroundColor:kRGBColor(55, 55, 55)
                                                           JianjieLabelText:@"   《诗经》是中国古代诗歌开端，最早的一部诗歌总集。搜集了公元前11世纪至前6世纪的古代诗歌305首，除此之外还有6篇有题目无内容，即有目无辞，称为笙诗六篇（南陔、白华、华黍、由康、崇伍、由仪），反映了西周初期到春秋中叶约五百年间的社会面貌。《诗经》内容丰富，反映了劳动与爱情、战争与徭役、压迫与反抗、风俗与婚姻、祭祖与宴会，甚至天象、地貌、动物、植物等方方面面"];
    self.shijingTableView.tableFooterView = [UIView new];
    self.shijingTableView.sectionIndexColor = [UIColor redColor];
    self.shijingTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.shijingTableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.shijingTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.shijingTableView];
    [self.shijingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.shijingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kShijingTableViewCellIdentifier];
    [self.shijingTableView registerClass:[SectionHeadView class] forHeaderFooterViewReuseIdentifier:kShijianTableViewSectionHeadViewIdentifier];
    __weak __typeof(self) _self = self;
    self.shijingTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.shijingVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.shijingTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.shijingTableView.tableHeaderView = _self.poemsTableViewHeadView;
               [_self.shijingTableView reloadData];
           }
           [_self.shijingTableView.header endRefreshing];
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"诗经";
    [self initToCollectionPoemBarBtn];
    [self initShijingVM];
    [self initShijingTableView];
    [self.shijingTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shijingVM.rowNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shijingVM getShijingListModelForSection:section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShijingTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.shijingVM getTitleForSection:indexPath.section Row:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                                              [self.shijingVM getIdForSection:indexPath.section Row:indexPath.row] PoemTitle:
                                              [self.shijingVM getTitleForSection:indexPath.section Row:indexPath.row]
                                                                                                      AuthorName:nil];
    [self.navigationController pushViewController:poemDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *sectionHeadVeiw = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kShijianTableViewSectionHeadViewIdentifier];
    sectionHeadVeiw.titleLabel.text = [self.shijingVM getSectiontitleForSection:section];
    return sectionHeadVeiw;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.shijingVM.rowNumber; i++) {
        [indexArr addObject:[self.shijingVM getSectiontitleForSection:i]];
    }
    self.shijingTableView.sectionIndexColor = [UIColor redColor];
    self.shijingTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.shijingTableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    return indexArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.shijingTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.shijingVM getTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.shijingVM getIdForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] PoemTitle:
                               [self.shijingVM getTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] AuthorName:nil];
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
