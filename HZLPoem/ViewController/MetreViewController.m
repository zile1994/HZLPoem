//
//  MetreViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MetreViewController.h"
#import "MetreCell.h"
#import "YunzijiViewController.h"
#import "GelvjiViewController.h"
#import "PoemCommonSenseViewController.h"
#import "AppreciatePoemViewController.h"
#import "CollectionShilvViewController.h"


#define kMetreTableViewCellIdentifer  @"metreTableViewCell"
extern NSString * const TouchCollectionOtherViewControllerToTabBar;
extern NSString * const TouchFamousAuthorAndSearchViewControllerPopToTabBar;

@interface MetreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *metreTableView;
@property (nonatomic, strong) NSArray *titleLabelArr;
@property (nonatomic, strong) NSArray *descLabelArr;
@property (nonatomic, strong) NSArray *cellImageArr;
@property (nonatomic, strong) UIView *metreTableViewHeadView;

@end

@implementation MetreViewController

- (void)initTitleLabelArr {
    self.titleLabelArr = @[@"韵字集", @"格律集", @"诗词常识集", @"如何欣赏诗词"];
}

- (void)initDescLabelArr {
    self.descLabelArr = @[@"收录了《中华新韵》、《平水韵》、《词林正韵》等韵书", @"目前收录了十六个诗的格式以及两千余个词牌名", @"详细介绍格律、法度、炼字、对仗、寄托等诗词创作中的常识", @"选取了古典文学研究大家名文，揭示古典诗词学习的门径"];
}

- (void)initCellImageArr {
    self.cellImageArr = @[@"yunzijiimage", @"gelvjiimage", @"gushicijianshang", @"shicichangshi"];
}

- (void)initMetreTableViewHeadView {
    self.metreTableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"metreheadview"]];
    [self.metreTableViewHeadView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.metreTableViewHeadView);
    }];
    UILabel *metreHeadLabel = [[UILabel alloc] init];
    metreHeadLabel.backgroundColor = [UIColor clearColor];
//    metreHeadLabel.text = @"   韵是诗词格律的基本要素之一。诗人在诗词中用韵，叫做押韵。所谓韵部，就是将相同韵母的字归纳到一类，这种类别即为韵部。";
    metreHeadLabel.font = [UIFont boldFlatFontOfSize:16];
    metreHeadLabel.preferredMaxLayoutWidth = self.view.frame.size.width - 40;
    metreHeadLabel.numberOfLines = 0;
    [self.metreTableViewHeadView addSubview:metreHeadLabel];
    [metreHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.metreTableViewHeadView);
    }];
    UIButton *collectionMetreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionMetreButton setBackgroundColor:[UIColor clearColor]];
    [self.metreTableViewHeadView addSubview:collectionMetreButton];
    [collectionMetreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.metreTableViewHeadView);
    }];
    [collectionMetreButton addTarget:self action:@selector(toCollectionShilvViewController) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)toCollectionShilvViewController {
    CollectionShilvViewController *collectionShilvVC = [[CollectionShilvViewController alloc] init];
    [collectionShilvVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:collectionShilvVC animated:YES];
}

- (void)initMetreTableView {
    self.metreTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.metreTableView.delegate = self;
    self.metreTableView.dataSource = self;
    self.metreTableView.tableHeaderView = self.metreTableViewHeadView;
    self.metreTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.metreTableView];
    [self.metreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.metreTableView registerClass:[MetreCell class] forCellReuseIdentifier:kMetreTableViewCellIdentifer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"诗律";
    [self initTitleLabelArr];
    [self initDescLabelArr];
    [self initCellImageArr];
    [self initMetreTableViewHeadView];
    [self initMetreTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToTabBar) name:TouchCollectionOtherViewControllerToTabBar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToTabBar) name:TouchFamousAuthorAndSearchViewControllerPopToTabBar object:nil];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)popToTabBar {
    UIViewController *vc = self.navigationController.viewControllers.lastObject;
    if (![vc isKindOfClass:[MetreViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleLabelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MetreCell *cell = [tableView dequeueReusableCellWithIdentifier:kMetreTableViewCellIdentifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.descImageView.image = [UIImage imageNamed:self.cellImageArr[indexPath.row]];
    cell.titleLabel.text = self.titleLabelArr[indexPath.row];
    cell.descLabel.text = self.descLabelArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [[YunzijiViewController alloc] init];
    } else if (indexPath.row == 1) {
        viewController = [[GelvjiViewController alloc] init];
    } else if (indexPath.row == 2) {
        viewController = [[PoemCommonSenseViewController alloc] init];
    } else if (indexPath.row == 3) {
        viewController = [[AppreciatePoemViewController alloc] init];
    }
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //动态计算高度
//    NSDictionary *titleDic = @{NSFontAttributeName: [UIFont boldFlatFontOfSize:16]};
//    NSDictionary *descDic = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//    CGFloat labelConstraintWidth = self.view.frame.size.width - 80 - 30;
//    CGSize titleLabelSize = [self.titleLabelArr[indexPath.row] boundingRectWithSize:CGSizeMake(labelConstraintWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleDic context:nil].size;
//    CGSize descLabelSize = [self.descLabelArr[indexPath.row] boundingRectWithSize:CGSizeMake(labelConstraintWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOriginattributes:descDic context:nil].size;
//    return 10 + titleLabelSize.height + 10 + descLabelSize.height + 10;
    return 75;
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    [self setPeekIndexPathSourceRectWithTableView:self.metreTableView previewingContext:previewingContext Location:location];
    switch (self.peekIndexPath.row) {
        case 0: {
            self.peekViewController = [[YunzijiViewController alloc] init];
        }
            break;
        case 1: {
            self.peekViewController = [[GelvjiViewController alloc] init];
        }
            break;
        case 2: {
            self.peekViewController = [[PoemCommonSenseViewController alloc] init];
        }
            break;
        case 3: {
            self.peekViewController = [[AppreciatePoemViewController alloc] init];
        }
            break;
        default:
            break;
    }
    self.peekHeadLabel.text = self.titleLabelArr[self.peekIndexPath.row];
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
