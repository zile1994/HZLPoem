//
//  SetupBaseViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/7.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperateCollectionView.h"
#import "NoCollectionView.h"
#import "ToolClass.h"
#import "BaseTableViewCell.h"

@interface SetupBaseViewController : UIViewController

@property (nonatomic, strong) OperateCollectionView *operateCollectionView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResultArr;
@property (nonatomic, strong) NSMutableArray *selectedArr;
@property (nonatomic, strong) NoCollectionView *noCollectionView;
@property (nonatomic, strong) UIBarButtonItem *deleteBarBtn;
@property (nonatomic, strong) UIBarButtonItem *cancelBarBtn;
@property (nonatomic, strong) NSIndexPath *peekIndexPath;
@property (nonatomic, strong) UILabel *peekHeadLabel;
@property (nonatomic, strong) UIViewController *peekViewController;

- (void)initOperateCollectionView;
- (void)initSearchController;
- (void)initNoCollectionView;
- (void)setDeleteBtnTitleColor;
- (void)setPeekIndexPathSourceRectWithTableView:(UITableView *)tableView previewingContext:(id<UIViewControllerPreviewing>)previewingContext Location:(CGPoint)location;
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit;

@end
