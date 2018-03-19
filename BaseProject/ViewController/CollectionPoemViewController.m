//
//  CollectionPoemViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CollectionPoemViewController.h"
#import "PoemDetailViewController.h"
#import "NoCollectionView.h"
#import "PoemDetailViewController.h"
#import "ToolClass.h"
#import "CollectionPoem.h"

#define kPoemTableViewCellIdentifier  @"PoemTableViewCell"

extern NSString * const CollectionPoemPath;

@interface CollectionPoemViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *collectionPoemListTableView;
@property (nonatomic, strong) NSString *collectionPoemPath;
@property (nonatomic, strong) NSMutableArray *collectionPoemArr;


@end

@implementation CollectionPoemViewController

- (void)initCollectionPoemArr {
    NSString *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    self.collectionPoemPath = [filepath stringByAppendingPathComponent:CollectionPoemPath];
    self.collectionPoemArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionPoemPath];
    self.searchResultArr = self.collectionPoemArr;
}

- (void)addNoCollectionView {
    [self.view addSubview:self.noCollectionView];
    [self.noCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@220);
    }];
}

- (void)initCollectionPoemListTableView {
    self.collectionPoemListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.collectionPoemListTableView.delegate = self;
    self.collectionPoemListTableView.dataSource = self;
    self.collectionPoemListTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.collectionPoemListTableView];
    [self.collectionPoemListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.collectionPoemListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kPoemTableViewCellIdentifier];
    if (!(self.collectionPoemArr.count == 0)) {
        self.collectionPoemListTableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchResultsUpdater = self;
        self.searchController.searchBar.placeholder = @"请输入作品或作品名";
    }
}

- (void)initDeleteBarBtn {
    self.deleteBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(toEditingCollectionPoem)];
    if (self.collectionPoemArr.count != 0) {
        self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
    }
}

- (void)initCancelBarBtn {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 40, 40);
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBarBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    [cancelButton addTarget:self action:@selector(toCancelEditingCollectionPoem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initOperateCollectionView {
    [super initOperateCollectionView];
    [self.view addSubview:self.operateCollectionView];
    [self.operateCollectionView.allSelectedBtn addTarget:self action:@selector(toSelectedAllCollectionPoem) forControlEvents:UIControlEventTouchUpInside];
    [self.operateCollectionView.delectedBtn addTarget:self action:@selector(toDeleteCollectionPoem) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toSelectedAllCollectionPoem {
    if (!self.operateCollectionView.allSelectedBtn.isSelecting) {
        NSInteger count = self.collectionPoemArr.count;
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionPoemListTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedArr addObject:self.collectionPoemArr[i]];
        }
        [self setDeleteBtnTitleColor];
        self.operateCollectionView.allSelectedBtn.isSelecting = YES;
        [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
    } else {
        NSInteger count = self.collectionPoemArr.count;
        for (NSInteger i = 0; i < count ; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.collectionPoemListTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        [self.selectedArr removeAllObjects];
        [self setDeleteBtnTitleColor];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
}

- (void)toDeleteCollectionPoem {
    if (self.selectedArr.count > 0) {
        [self.collectionPoemArr removeObjectsInArray:self.selectedArr];
        [self.collectionPoemListTableView reloadData];
        [ToolClass archivedOfObject:self.collectionPoemArr toPath:self.collectionPoemPath];
        if (self.collectionPoemArr.count == 0) {
            self.navigationItem.rightBarButtonItem = nil;
            [self.collectionPoemListTableView removeFromSuperview];
            [self addNoCollectionView];
        } else {
            self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.searchController.searchBar.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
            self.searchController.searchBar.userInteractionEnabled = YES;
        }
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.operateCollectionView.frame = CGRectMake(0, kWindowH, kWindowW, 45);
        } completion:^(BOOL finished) {
            [self setDeleteBtnTitleColor];
            [self.selectedArr removeAllObjects];
            [self.collectionPoemListTableView setEditing:NO animated:YES];
        }];
    }
}

- (void)toEditingCollectionPoem {
    [self.collectionPoemListTableView setEditing:YES animated:YES];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight - 45, kWidth, 45);
        self.searchController.searchBar.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.searchController.searchBar.userInteractionEnabled = NO;
        self.navigationItem.rightBarButtonItem = self.cancelBarBtn;
    }];
}

- (void)toCancelEditingCollectionPoem {
    [self.selectedArr removeAllObjects];
    [self.collectionPoemListTableView setEditing:NO animated:YES];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.operateCollectionView.frame = CGRectMake(0, kHeight, kWindowW, 45);
        self.searchController.searchBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.navigationItem.rightBarButtonItem = self.deleteBarBtn;
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
        self.searchController.searchBar.userInteractionEnabled = YES;
        [self setDeleteBtnTitleColor];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏的古文";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCollectionPoemArr];
    [self initDeleteBarBtn];
    [self initCancelBarBtn];
    [self initCollectionPoemListTableView];
    [self initOperateCollectionView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.noCollectionView removeFromSuperview];
    [self initCollectionPoemArr];
    [self.collectionPoemListTableView reloadData];
    if (self.collectionPoemArr.count == 0) {
        self.navigationItem.rightBarButtonItem = nil;
        [self addNoCollectionView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchResultArr || self.searchResultArr.count == 0) {
        self.searchResultArr = self.collectionPoemArr;
    }
    return self.searchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kPoemTableViewCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CollectionPoem *poem = self.searchResultArr[indexPath.row];
    cell.textLabel.text = poem.author;
    cell.textLabel.textColor = kRGBColor(253, 147, 66);
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.detailTextLabel.font = [UIFont boldFlatFontOfSize:18];
    cell.detailTextLabel.text = poem.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        [self.selectedArr addObject:self.collectionPoemArr[indexPath.row]];
        [self setDeleteBtnTitleColor];
        if (self.selectedArr.count == self.collectionPoemArr.count) {
            [self.operateCollectionView.allSelectedBtn setTitle:@"取消全选" forState:UIControlStateNormal];
            self.operateCollectionView.allSelectedBtn.isSelecting = YES;
        }
    } else {
        CollectionPoem *poem = self.searchResultArr[indexPath.row];
        PoemDetailViewController *poemdetailVC = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:poem.viewid PoemTitle:poem.title AuthorName:poem.author];
        [self.navigationController pushViewController:poemdetailVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
        [self.selectedArr removeObject:self.collectionPoemArr[indexPath.row]];
        [self setDeleteBtnTitleColor];
        [self.operateCollectionView.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.operateCollectionView.allSelectedBtn.isSelecting = NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *filteString = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains [c] %@ || author contains [c] %@", filteString, filteString];
    self.searchResultArr = [NSMutableArray arrayWithArray:[self.collectionPoemArr filteredArrayUsingPredicate:predicate]];
    [self.collectionPoemListTableView reloadData];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *str = self.collectionPoemArr[sourceIndexPath.row];
    [self.collectionPoemArr removeObjectAtIndex:sourceIndexPath.row];
    [self.collectionPoemArr insertObject:str atIndex:destinationIndexPath.row];
    [ToolClass archivedOfObject:self.collectionPoemArr toPath:self.collectionPoemPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.collectionPoemListTableView previewingContext:previewingContext Location:location];
    CollectionPoem *poem = self.searchResultArr[self.peekIndexPath.row];
    self.peekHeadLabel.text = poem.title;
    self.peekViewController = [[PoemDetailViewController alloc] initPoemDetailControllerWithViewid:poem.viewid PoemTitle:poem.title AuthorName:poem.author];
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
