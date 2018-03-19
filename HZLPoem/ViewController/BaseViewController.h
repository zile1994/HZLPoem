//
//  BaseViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoSearchResultView.h"
#import "NoResultOfSearchView.h"
#import "ToolClass.h"
#import "BaseTableViewCell.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *cacheAuthorImagePath;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResultArr;
@property (nonatomic, strong) UIBarButtonItem *toCollectionPoemBarBtn;
@property (nonatomic, strong) UIBarButtonItem *toCollectionAuthorBarBtn;
//@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSIndexPath *peekIndexPath;
@property (nonatomic, strong) UILabel *peekHeadLabel;
@property (nonatomic, strong) UIViewController *peekViewController;

/**没有符合搜索条件返回数据*/
@property (nonatomic, strong) NoResultOfSearchView *noResultOfSearchView;
/**断网没返回数据*/
@property (nonatomic, strong) NoSearchResultView *noSearchResultView;

/**因没有符合条件的返回值创建视图*/
- (void)initNoResultOfSearchView;

/**创建前往诗词收藏的图标*/
- (void)initToCollectionPoemBarBtn;

/**创建前往诗人收藏的图标*/
- (void)initToCollectionAuthorBarBtn;

/**因断网没有返回值创建视图*/
- (void)initNoSearchResultView;

/**设置peek参数*/
- (void)setPeekIndexPathSourceRectWithTableView:(UITableView *)tableView previewingContext:(id<UIViewControllerPreviewing>)previewingContext Location:(CGPoint)location;

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit;

@end
