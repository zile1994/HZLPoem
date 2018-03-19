//
//  OtherGuShiWenViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "OtherGuShiWenViewController.h"
#import "OtherGuShiWenViewModel.h"
#import "SectionHeadView.h"
#import "PoemDetailViewController.h"
#import "NoSearchResultView.h"
#import "PoemsTableViewHeadView.h"
#import "ToolClass.h"


#define kOtherGuShiWenTableViewCellIdentifier  @"otherGuShiWenTableViewCell"
#define kOtherGuShiWenTableViewSectionHeadViewIdentifier  @"otherGuShiWenTableViewSectionHeadView"
#define kOtherGuShiwenTableViewCellTextLabelFont  15
#define kOtherGuShiwenTableViewCellDetailTextLabelFont  17
#define kPoemTableViewHVHeight  188 + 20


@interface OtherGuShiWenViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) OtherGuShiWenViewModel *otherGuShiWenVM;
@property (nonatomic, strong) UITableView *otherGuShiWenTableView;
@property (nonatomic, strong) PoemsTableViewHeadView *poemTableViewHV;

@end

@implementation OtherGuShiWenViewController

- (id)initOtherGuShiWenViewControllerWithType:(NSString *)type TitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.type = type;
        self.titleName = titleName;
    }
    return self;
}

- (void)initOtherGuShiWenVM {
    self.otherGuShiWenVM = [[OtherGuShiWenViewModel alloc] initOtherGuShiWenWithType:self.type];
}

- (void)initPoemsTableViewHV {
    if ([self.titleName isEqualToString:@"古文观止"]) {
        self.poemTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, kWidth, kPoemTableViewHVHeight)
                                                           PoemImageName:@"guwenguanzhiheadview"
                                                         BackgroundColor:kRGBColor(55, 55, 55)
                                                        JianjieLabelText:@"  《古文观止》是历代中国散文总集。清代吴楚材、吴调侯编选，吴兴祚审定。清朝康熙年间选编的一部供学塾使用的文学读本。“观止”一词表示“文集所收录的文章代表文言文的最高水平”。作为一种古代汉民族散文的入门书，仍有其存在价值。"];
    } else if ([self.titleName isEqualToString:@"乐府"]) {
        self.poemTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, kWidth, kPoemTableViewHVHeight)
                                                           PoemImageName:@"yuefuheadview"
                                                         BackgroundColor:kRGBColor(55, 55, 55)
                                                        JianjieLabelText:@"   “乐府”本是汉武帝设立的音乐机构．用来训练乐工．制定乐谱和采集歌词，其中采集了大量民歌，后来，“乐府”成为一种带有音乐性的诗体名称。今保存的汉乐府民歌的五六十首，真实地反映了下层人民的苦难生活。"];
    } else if ([self.titleName isEqualToString:@"古诗三百首"]) {
        self.poemTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, kWidth, kPoemTableViewHVHeight)
                                
                                                           PoemImageName:@"gushisanbaishouheadview"
                                                         BackgroundColor:kRGBColor(55, 55, 55)
                                                        JianjieLabelText:@"   选编了从上古到晚清共两千多年近两百位诗人约三百首诗歌作品，囊括了历代诗人的杰出作品。处处闪烁着中华经典古诗的智慧之光。"];
    } else if ([self.titleName isEqualToString:@"宋词三百首"]) {
        self.poemTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, kWidth, kPoemTableViewHVHeight)
                                                           PoemImageName:@"songcisanbaishouheadview"
                                                         BackgroundColor:kRGBColor(55, 55, 55)
                                                        JianjieLabelText:@"   宋代盛行的一种汉族文学体裁，宋词是一种相对于古体诗的新体诗歌之一，标志宋代文学的最高成就。宋词句子有长有短，便于歌唱。因是合乐的歌词，故又称曲子词、乐府、乐章、长短句、诗余、琴趣等。它始于梁代，形成于唐代而极盛于宋代。宋词是中国古代汉族文学皇冠上光辉夺目的明珠，历来与唐诗并称双绝。"];
    } else if ([self.titleName isEqualToString:@"唐诗三百首"]) {
        self.poemTableViewHV = [ToolClass setPoemsTableHeadViewWithFrame:CGRectMake(0, 0, kWidth, kPoemTableViewHVHeight)
                                                           PoemImageName:@"tangshisanbaishouheadview"
                                                         BackgroundColor:kRGBColor(55, 55, 55)
                                                        JianjieLabelText:@"   唐诗泛指创作于唐朝的诗。唐诗是中华民族最珍贵的文化遗产之一，是中华文化宝库中的一颗明珠，同时也对世界上许多民族和国家的文化发展产生了很大影响，对于后人研究唐代的政治、民情、风俗等都有重要的参考意义。"];
    }
}

- (void)initOtherGuShiWenTableView {
    self.otherGuShiWenTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.otherGuShiWenTableView.delegate = self;
    self.otherGuShiWenTableView.dataSource = self;
    self.otherGuShiWenTableView.tableFooterView = [UIView new];
    self.otherGuShiWenTableView.sectionIndexColor = [UIColor redColor];
    self.otherGuShiWenTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.otherGuShiWenTableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:self.otherGuShiWenTableView];
    [self.otherGuShiWenTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.otherGuShiWenTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kOtherGuShiWenTableViewCellIdentifier];
    [self.otherGuShiWenTableView registerClass:[SectionHeadView class] forHeaderFooterViewReuseIdentifier:kOtherGuShiWenTableViewSectionHeadViewIdentifier];
    __weak __typeof(self) _self = self;
    self.otherGuShiWenTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [_self.otherGuShiWenVM refreshDataCompletionHandle:^(NSError *error) {
           if (error) {
               _self.otherGuShiWenTableView.tableHeaderView = _self.noSearchResultView;
           } else {
               [_self.noSearchResultView removeFromSuperview];
               _self.otherGuShiWenTableView.tableHeaderView = _self.poemTableViewHV;
               [_self.otherGuShiWenTableView reloadData];
           }
           [_self.otherGuShiWenTableView.header endRefreshing];
       }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    [self initToCollectionPoemBarBtn];
    [self initOtherGuShiWenVM];
    [self initPoemsTableViewHV];
    [self initOtherGuShiWenTableView];
    [self.otherGuShiWenTableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.otherGuShiWenVM.rowNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.otherGuShiWenVM getOtherGuShiWenListModelForSection:section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell  = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kOtherGuShiWenTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.font = [UIFont systemFontOfSize:kOtherGuShiwenTableViewCellTextLabelFont];
    cell.detailTextLabel.font = [UIFont boldFlatFontOfSize:kOtherGuShiwenTableViewCellDetailTextLabelFont];
    cell.detailTextLabel.text = [self.otherGuShiWenVM getOtherGuShiWenListItemsModelTitleForSection:indexPath.section Row:indexPath.row];
    cell.textLabel.text = [self.otherGuShiWenVM getOtherGuShiWenListItemsModelAuthorForSection:indexPath.section Row:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *sectionTitleArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.otherGuShiWenVM.rowNumber; i++) {
        [sectionTitleArr addObject:[self.otherGuShiWenVM getOtherGuShiWenListModelTitleWithSection:i]];
    }
    return sectionTitleArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kOtherGuShiWenTableViewSectionHeadViewIdentifier];
    if ([self.titleName isEqualToString:@"小学文言文"]) {
        sectionHeadView.titleLabel.text = @"小学文言文";
    } else {
       sectionHeadView.titleLabel.text = [self.otherGuShiWenVM getOtherGuShiWenListModelTitleWithSection:section];
    }
    return sectionHeadView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoemDetailViewController *poemDetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:[self.otherGuShiWenVM getOtherGuShiWenListItemsModelIdForSection:indexPath.section Row:indexPath.row] PoemTitle:[self.otherGuShiWenVM getOtherGuShiWenListItemsModelTitleForSection:indexPath.section Row:indexPath.row] AuthorName:[self.otherGuShiWenVM getOtherGuShiWenListItemsModelAuthorForSection:indexPath.section Row:indexPath.row]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:poemDetailVC animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.otherGuShiWenTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = [self.otherGuShiWenVM getOtherGuShiWenListItemsModelTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row];
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:
                               [self.otherGuShiWenVM getOtherGuShiWenListItemsModelIdForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] PoemTitle:
                               [self.otherGuShiWenVM getOtherGuShiWenListItemsModelTitleForSection:self.peekIndexPath.section Row:self.peekIndexPath.row] AuthorName:
                               [self.otherGuShiWenVM getOtherGuShiWenListItemsModelAuthorForSection:self.peekIndexPath.section Row:self.peekIndexPath.row]];
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
/**如图，在界面的上方显示的是界面标题，在下面有一个视图，当用户点击视图相应的标题时，会弹出相应类型的诗文筛选条件的菜单。用户每点击不同的筛选条件时，界面都会重新加载，当没有符合筛选条件的诗文时，界面就会显示无符合条件的诗文的提示视图；而当应用因为断网或者网络*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
