//
//  MetreBaseViewController.h
//  BaseProject
//
//  Created by 黄子乐 on 16/4/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoSearchResultView.h"
#import "PoemsTableViewHeadView.h"
#import "BaseTableViewCell.h"

@interface MetreBaseViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *collectionShilvBarBtn;
@property (nonatomic, strong) UIBarButtonItem *cancelCollectionShilvBarBtn;
@property (nonatomic, strong) UIBarButtonItem *toCollectionBarBtn;
@property (nonatomic, strong) NoSearchResultView *noSearchResultView;
@property (nonatomic, strong) PoemsTableViewHeadView *poemsTableViewHeadView;
@property (nonatomic, strong) NSIndexPath *peekIndexPath;
@property (nonatomic, strong) UILabel *peekHeadLabel;
@property (nonatomic, strong) UIViewController *peekViewController;

/**创建前往收藏格律的图标*/
- (void)initToCollectionBarBtn;

- (void)setPeekIndexPathSourceRectWithTableView:(UITableView *)tableView previewingContext:(id<UIViewControllerPreviewing>)previewingContext Location:(CGPoint)location;

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit;

@end
