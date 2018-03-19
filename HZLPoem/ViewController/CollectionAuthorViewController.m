//
//  CollectionAuthorViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/15.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionAuthorViewController.h"
#import "NoCollectionView.h"
#import "FamousAuthorDetailViewController.h"
#import "ToolClass.h"


#define kCollectionAuthotTableViewCellIndetifier  @"collectionAuthorCell"
extern NSString * const CollectionAuthorPath;

@interface CollectionAuthorViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *collectionAuthorArr;
@property (nonatomic, strong) NSString *collectionAuthorPath;
@property (nonatomic, strong) UITableView *collectionAuthorTableView;

@end

@implementation CollectionAuthorViewController

- (void)initCollectionAuthorArr {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.collectionAuthorPath = [path stringByAppendingPathComponent:CollectionAuthorPath];
    self.collectionAuthorArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionAuthorPath];
    self.searchResultArr = self.collectionAuthorArr;
}

- (void)addNoCollectionView {
    [self.view addSubview:self.noCollectionView];
    [self.noCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@220);
    }];
}

- (void)initOperateCollectionView {
    [super initOperateCollectionView];
    [self.view addSubview:self.operateCollectionView];
    [self.operateCollectionView.allSelectedBtn addTarget:self action:@selector(toSelectedAllCollectionAuthor) forControlEvents:UIControlEventTouchUpInside];
    [self.operateCollectionView.delectedBtn addTarget:self action:@selector(toDeleteCollectionAuthor) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toSelectedAllCollectionAuthor {
    if (!self.operateCollectionView.allSelectedBtn.isSelecting) {
        NSInteger count = self.collectionAuthorArr.count;
        for (NSInteger i = 0 ; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionAuthorTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedArr addObject:self.collectionAuthorArr[indexPath.row]];
        }
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = YES;
    } else {
        NSInteger count = self.collectionAuthorArr.count;
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionAuthorTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        [self.selectedArr removeAllObjects];
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }
}

- (void)toDeleteCollectionAuthor {
    if (self.selectedArr.count > 0) {
        [self.collectionAuthorTableView setEditing:NO animated:YES];
        [self.collectionAuthorArr removeObjectsInArray:self.selectedArr];
        [self.collectionAuthorTableView reloadData];
        [ToolClass archivedOfObject:self.collectionAuthorArr toPath:self.collectionAuthorPath];
        if (self.collectionAuthorArr.count == 0) {
            self.navigationItem.rightBarButtonItem = nil;
            [self.collectionAuthorTableView removeFromSuperview];
            [self addNoCollectionView];
        } else {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.searchController.searchBar.alpha = 1.0;
            } completion:^(BOOL finished) {
                self.searchController.searchBar.userInteractionEnabled = YES;
            }];
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

- (void)initCollectionAuthorTableView {
    self.collectionAuthorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.collectionAuthorTableView.delegate = self;
    self.collectionAuthorTableView.dataSource = self;
    self.collectionAuthorTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.collectionAuthorTableView];
    [self.collectionAuthorTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionAuthorTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCollectionAuthotTableViewCellIndetifier];
    if (self.collectionAuthorArr.count != 0) {
        self.collectionAuthorTableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchResultsUpdater = self;
        self.searchController.searchBar.placeholder = @"请输入作者名";
    }
}

- (void)initDeleteBarBtn {
    self.deleteBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(toEditingCollectionAuthor)];
    if (self.collectionAuthorArr.count > 0) {
        self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    }
}

- (void)toEditingCollectionAuthor {
    [self.collectionAuthorTableView setEditing:YES animated:YES];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight - 45, kWidth, 45);
        self.searchController.searchBar.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.searchController.searchBar.userInteractionEnabled = NO;
        self.navigationItem.rightBarButtonItem = self.cancelBarBtn;
    }];
}

- (void)initCancelBarBtn {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 40, 40);
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBarBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    [cancelButton addTarget:self action:@selector(toCancelEditingCollectionAuthor) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toCancelEditingCollectionAuthor {
    [self.collectionAuthorTableView setEditing:NO animated:YES];
    [self.selectedArr removeAllObjects];
    self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    [self setDeleteBtnTitleColor];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight, kWidth, 45);
        self.searchController.searchBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
        self.searchController.searchBar.userInteractionEnabled = YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏的作者";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCollectionAuthorArr];
    [self initDeleteBarBtn];
    [self initCancelBarBtn];
    [self initCollectionAuthorTableView];
    [self initOperateCollectionView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.noCollectionView removeFromSuperview];
    [self initCollectionAuthorArr];
    [self.collectionAuthorTableView reloadData];
    if (self.collectionAuthorArr.count == 0) {
        self.navigationItem.rightBarButtonItem = nil;
        [self addNoCollectionView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchResultArr || self.searchResultArr.count == 0) {
        self.searchResultArr = self.collectionAuthorArr;
    }
    return self.searchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCollectionAuthotTableViewCellIndetifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.searchResultArr[indexPath.row];
    cell.textLabel.font = [UIFont boldFlatFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        [self.selectedArr addObject:self.collectionAuthorArr[indexPath.row]];
        [self setDeleteBtnTitleColor];
        if (self.selectedArr.count == self.collectionAuthorArr.count) {
            [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
            self.operateCollectionView.allSelectedBtn.isSelecting = YES;
        }
    } else {
        FamousAuthorDetailViewController *famousAuthordetailVC = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:self.searchResultArr[indexPath.row]];
        [self.navigationController pushViewController:famousAuthordetailVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        [self.selectedArr removeObject:self.collectionAuthorArr[indexPath.row]];
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *str = self.collectionAuthorArr[sourceIndexPath.row];
    [self.collectionAuthorArr removeObjectAtIndex:sourceIndexPath.row];
    [self.collectionAuthorArr insertObject:str atIndex:destinationIndexPath.row];
    [ToolClass archivedOfObject:self.collectionAuthorArr toPath:self.collectionAuthorPath];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *filteString = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filteString];
    self.searchResultArr = [NSMutableArray arrayWithArray:[self.collectionAuthorArr filteredArrayUsingPredicate:predicate]];
    [self.collectionAuthorTableView reloadData];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.collectionAuthorTableView previewingContext:previewingContext Location:location];
    self.peekHeadLabel.text = self.searchResultArr[self.peekIndexPath.row];;
    self.peekViewController = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:self.searchResultArr[self.peekIndexPath.row]];
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
