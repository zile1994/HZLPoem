//
//  CollectionShilvViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionShilvViewController.h"
#import "ToolClass.h"
#import "CollectionRhyme.h"
#import "ChineseRhymeDetailViewController.h"
#import "CollectionGelv.h"
#import "SectionHeadView.h"
#import "GelvjiDetailViewController.h"


extern NSString * const CollectionRhymePath;
extern NSString * const CollectionGelvPath;

#define kCollectionShilvTableViewCellIdentifier  @"collectionShilvTableViewCell"
#define kCollectionShilvTableViewHeaderFooterForSectionIdnetifier  @"collectionSHilvTableViewHeadSectionView"

@interface CollectionShilvViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *collectionRhymePath;
@property (nonatomic, strong) NSMutableArray *collectionRhymeArr;
@property (nonatomic, strong) NSString *collectionGelvPath;
@property (nonatomic, strong) NSMutableArray *collectionGelvArr;
@property (nonatomic, strong) UITableView *collectionShilvTableView;
@property (nonatomic, strong) NSArray *sectionTitleArr;

@end

@implementation CollectionShilvViewController

- (void)initCollectionRhymeArr {
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.collectionRhymePath = [filePath stringByAppendingPathComponent:CollectionRhymePath];
    self.collectionRhymeArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionRhymePath];
}

- (void)initCollectionGelvArr {
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.collectionGelvPath = [filePath stringByAppendingPathComponent:CollectionGelvPath];
    self.collectionGelvArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionGelvPath];
}

- (void)addNoCollectionView {
    [self.view addSubview:self.noCollectionView];
    [self.noCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@220);
    }];
}

- (void)initCollectionShilvTableView {
    self.collectionShilvTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.collectionShilvTableView.delegate = self;
    self.collectionShilvTableView.dataSource = self;
    self.collectionShilvTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.collectionShilvTableView];
    [self.collectionShilvTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionShilvTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCollectionShilvTableViewCellIdentifier];
    [self.collectionShilvTableView registerClass:[SectionHeadView class] forHeaderFooterViewReuseIdentifier:kCollectionShilvTableViewHeaderFooterForSectionIdnetifier];
}

- (void)initSectionTitleArr {
    self.sectionTitleArr = @[@"韵字", @"格律"];
}

- (void)initDeleteBarBtn {
    self.deleteBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(toEditingCollection)];
    if (!(self.collectionRhymeArr.count == 0 && self.collectionGelvArr.count == 0)) {
        self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    }
}

- (void)initCancelBarBtn {
    UIButton *button = [ToolClass setButtonWithTitlt:@"取消" BackgroundColor:[UIColor clearColor] TitleColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 44, 44)];
    self.cancelBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(toCancelEditingCollection) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toEditingCollection {
    [self.collectionShilvTableView setEditing:YES animated:YES];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight - 45, kWidth, 45);
    } completion:^(BOOL finished) {
        self.navigationItem.rightBarButtonItem = self.cancelBarBtn;
    }];
}

- (void)toCancelEditingCollection {
    [self.collectionShilvTableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    [self.selectedArr removeAllObjects];
    self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    [self setDeleteBtnTitleColor];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight, kWidth, 45);
    } completion:^(BOOL finished) {
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }];
}

- (void)initOperateCollectionView {
    [super initOperateCollectionView];
    [self.view addSubview:self.operateCollectionView];
    [self.operateCollectionView.allSelectedBtn addTarget:self action:@selector(toSelectAllCollection) forControlEvents:UIControlEventTouchUpInside];
    [self.operateCollectionView.delectedBtn addTarget:self action:@selector(toDeleteCollection) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toSelectAllCollection {
    if (!self.operateCollectionView.allSelectedBtn.isSelecting) {
        NSInteger rhymeArrCount = self.collectionRhymeArr.count;
        for (NSInteger i =0; i < rhymeArrCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionShilvTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedArr addObject:self.collectionRhymeArr[i]];
        }
        NSInteger gelvCount = self.collectionGelvArr.count;
        for (NSInteger i = 0; i < gelvCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            [self.collectionShilvTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedArr addObject:self.collectionGelvArr[i]];
        }
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = YES;
    } else {
        NSInteger rhymeArrCount = self.collectionRhymeArr.count;
        for (NSInteger i =0; i < rhymeArrCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionShilvTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        NSInteger gelvCount = self.collectionGelvArr.count;
        for (NSInteger i = 0; i < gelvCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            [self.collectionShilvTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        [self.selectedArr removeAllObjects];
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }
}

- (void)toDeleteCollection {
    if (self.selectedArr.count > 0) {
        [self.collectionShilvTableView setEditing:NO animated:YES];
        [self.collectionRhymeArr removeObjectsInArray:self.selectedArr];
        [self.collectionGelvArr removeObjectsInArray:self.selectedArr];
        [ToolClass archivedOfObject:self.collectionRhymeArr toPath:self.collectionRhymePath];
        [ToolClass archivedOfObject:self.collectionGelvArr toPath:self.collectionGelvPath];
        [self.collectionShilvTableView reloadData];
        if (self.collectionRhymeArr.count == 0 && self.collectionGelvArr.count == 0) {
            self.navigationItem.rightBarButtonItem = nil;
            [self.collectionShilvTableView removeFromSuperview];
            [self addNoCollectionView];
        } else {
            self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
        }
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.operateCollectionView.frame = CGRectMake(0, kHeight, kWidth, 45);
        } completion:^(BOOL finished) {
            [self.selectedArr removeAllObjects];
            [self setDeleteBtnTitleColor];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏的诗律";
    self.view.backgroundColor = kRGBColor(255, 255, 255);
    [self initCollectionRhymeArr];
    [self initSectionTitleArr];
    [self initCollectionShilvTableView];
    [self initDeleteBarBtn];
    [self initCancelBarBtn];
    [self initOperateCollectionView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.noCollectionView removeFromSuperview];
    [self initCollectionRhymeArr];
    [self initCollectionGelvArr];
    [self initDeleteBarBtn];
    [self initCancelBarBtn];
    [self.collectionShilvTableView reloadData];
    if (self.collectionRhymeArr.count == 0 && self.collectionGelvArr.count == 0) {
        [self addNoCollectionView];
        self.navigationItem.rightBarButtonItem = nil;
        [self.collectionShilvTableView removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.collectionRhymeArr.count == 0) {
            return 1;
        } else {
            return self.collectionRhymeArr.count;
        }
    } else if (section == 1) {
        if (self.collectionGelvArr.count == 0) {
            return 1;
        } else {
            return self.collectionGelvArr.count;
        }
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCollectionShilvTableViewCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.font = [UIFont boldFlatFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    if (indexPath.section == 0) {
        if (self.collectionRhymeArr.count == 0) {
            cell.detailTextLabel.text = @"没有收藏的韵字";
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            CollectionRhyme *rhyme = self.collectionRhymeArr[indexPath.row];
            cell.textLabel.text = rhyme.rhyHead;
            cell.detailTextLabel.text = rhyme.rhyMother;
        }
    } else if (indexPath.section == 1) {
        if (self.collectionGelvArr.count == 0) {
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @"没有收藏的格律";
            cell.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            CollectionGelv *gelv = self.collectionGelvArr[indexPath.row];
            cell.textLabel.text = gelv.name;
            cell.detailTextLabel.text = gelv.nameDetail;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        if (indexPath.section == 0) {
            [self.selectedArr addObject:self.collectionRhymeArr[indexPath.row]];
        } else {
            [self.selectedArr addObject:self.collectionGelvArr[indexPath.row]];
        }
        [self setDeleteBtnTitleColor];
        if (self.selectedArr.count == self.collectionGelvArr.count + self.collectionRhymeArr.count) {
            [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
            self.operateCollectionView.allSelectedBtn.isSelecting = YES;
        }
    } else {
        if (indexPath.section == 0) {
            CollectionRhyme *rhyme = self.collectionRhymeArr[indexPath.row];
            ChineseRhymeDetailViewController *chineseRhymeDetailVC = [[ChineseRhymeDetailViewController alloc] initChineseRhymeDetailViewControllerWithRhyHead:rhyme.rhyHead rhyMother:rhyme.rhyMother RhyContent:rhyme.rhyContent];
            [self.navigationController pushViewController:chineseRhymeDetailVC animated:YES];
        } else if (indexPath.section == 1) {
            CollectionGelv *gelv = self.collectionGelvArr[indexPath.row];
            GelvjiDetailViewController *gelvjiDetailVC = [[GelvjiDetailViewController alloc] initGelvjiDetailViewControllerWithName:gelv.name NameDetail:gelv.nameDetail Intro:gelv.intro Sample:gelv.sample MelodyNote:gelv.melodyNote];
            [self.navigationController pushViewController:gelvjiDetailVC animated:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        if (indexPath.section == 0) {
            [self.selectedArr removeObject:self.collectionRhymeArr[indexPath.row]];
        } else {
            [self.selectedArr removeObject:self.collectionGelvArr[indexPath.row]];
        }
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kCollectionShilvTableViewHeaderFooterForSectionIdnetifier];
    sectionHeadView.titleLabel.text = self.sectionTitleArr[section];
    return sectionHeadView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.collectionShilvTableView previewingContext:previewingContext Location:location];
    if (self.peekIndexPath.section == 0) {
        CollectionRhyme *rhyme = self.collectionRhymeArr[self.peekIndexPath.row];
        self.peekHeadLabel.text = rhyme.rhyHead;
        self.peekViewController = [[ChineseRhymeDetailViewController alloc] initChineseRhymeDetailViewControllerWithRhyHead:rhyme.rhyHead rhyMother:rhyme.rhyMother RhyContent:rhyme.rhyContent];
    } else {
        CollectionGelv *gelv = self.collectionGelvArr[self.peekIndexPath.row];
        self.peekHeadLabel.text = gelv.name;
         self.peekViewController = [[GelvjiDetailViewController alloc] initGelvjiDetailViewControllerWithName:gelv.name NameDetail:gelv.nameDetail Intro:gelv.intro Sample:gelv.sample MelodyNote:gelv.melodyNote];
    }
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
