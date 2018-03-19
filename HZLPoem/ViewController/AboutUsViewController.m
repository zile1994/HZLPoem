//
//  AboutUsViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ToolClass.h"
#import "PromptView.h"
#import "BaseTableViewCell.h"
//#import "UMSocial.h"


#define kAboutUsTableViewCellIdentifier  @"aboutUsCell"

@interface AboutUsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *aboutUsTableView;
@property (nonatomic, strong) UIView *aboutUsHeadView;
@property (nonatomic, strong) UIView *aboutUsFootView;
@property (nonatomic, strong) UIBarButtonItem *shareButton;

@end

@implementation AboutUsViewController

- (void)initAboutUsHeadView {
    self.aboutUsHeadView = [[UIView alloc] init];
    self.aboutUsHeadView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.layer.cornerRadius = 20;
    iconImageView.layer.masksToBounds = YES;
    [self.aboutUsHeadView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aboutUsHeadView.mas_top).with.offset(20);
        make.centerX.mas_equalTo(self.aboutUsHeadView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    iconImageView.image = [UIImage imageNamed:@"aboutusicon"];
    
    UILabel *jianjieLabel = [[UILabel alloc] init];
    jianjieLabel.textColor = kRGBColor(70, 70, 70);
    jianjieLabel.font = [UIFont systemFontOfSize:17];
    jianjieLabel.numberOfLines = 0;
    jianjieLabel.preferredMaxLayoutWidth = self.view.frame.size.width - 30;
    NSString *jianjieLabelText = @"    诗词古韵所有数据来自古诗文大全APP和口袋诗词APP.采用Charles抓包软件获取。诗词古韵专注于古诗文的服务，让广大古诗文爱好者更便捷的获取相关资料。我们提供了古代名著的原文及翻译，以及各个时代的诗、词、曲、辞赋等原文鉴赏及翻译。诗词古韵，您随身携带的华夏五千年。";
    jianjieLabel.text = jianjieLabelText;
    CGRect rect = [jianjieLabelText boundingRectWithSize:CGSizeMake(jianjieLabel.preferredMaxLayoutWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    [self.aboutUsHeadView addSubview:jianjieLabel];
    [jianjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.aboutUsHeadView.mas_left).with.offset(15);
    }];
    
    self.aboutUsHeadView.frame = CGRectMake(0, 0, self.view.frame.size.width, 140 + rect.size.height + 20);
}

- (void)initAboutUsFootView {
    self.aboutUsFootView = [[UIView alloc] init];
    self.aboutUsFootView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    self.aboutUsFootView.backgroundColor = [UIColor clearColor];
    UILabel *copyRightLabel = [[UILabel alloc] init];
    copyRightLabel.textAlignment = NSTextAlignmentCenter;
    copyRightLabel.numberOfLines = 0;
    copyRightLabel.text = @"Copyright © 2016年 黄子乐. All rights reserved.";
    copyRightLabel.textColor = [UIColor grayColor];
    copyRightLabel.font = [UIFont systemFontOfSize:13];
    [self.aboutUsFootView addSubview:copyRightLabel];
    [copyRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.aboutUsFootView);
    }];
}

- (void)initAboutUsTableView {
    self.aboutUsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self;
    self.aboutUsTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.aboutUsTableView.tableHeaderView = self.aboutUsHeadView;
    self.aboutUsTableView.tableFooterView = self.aboutUsFootView;
    [self.view addSubview:self.aboutUsTableView];
    [self.aboutUsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

//- (void)initShareButton {
//    self.shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareApp)];
//    self.navigationItem.rightBarButtonItem = self.shareButton;
//}

//- (void)shareApp {
//    UIImage *image = [UIImage imageNamed:@"aboutusicon"];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56eb5eb167e58e5b7a0020a0" shareText:[NSString stringWithFormat:@"我正在诗词古韵学习呢,你也快来吧"] shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToEmail,UMShareToQQ, UMShareToQzone,nil] delegate:self];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
//    [self initShareButton];
    [self initAboutUsHeadView];
    [self initAboutUsFootView];
    [self initAboutUsTableView];
    // Do any additional setup after loading the view.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"联系方式";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kAboutUsTableViewCellIdentifier];
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"联系电话";
        cell.detailTextLabel.text = @"18720987893";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ";
        cell.detailTextLabel.text = @"1799854003";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"微信";
        cell.detailTextLabel.text = @"RFhzl1994";
    } else {
    
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAction;
    if (indexPath.row == 0) {
        alertAction = [UIAlertAction actionWithTitle:@"拨打电话: 18720987893" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *phoneNumberURLString = [@"tel://" stringByAppendingString:@"18720987893"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberURLString]];
        }];
    } else if (indexPath.row == 1) {
        alertAction = [UIAlertAction actionWithTitle:@"复制QQ号码: 1799854003" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
            pastboard.string = @"1799854003";
            [self addPromptViewWithMessage:@"QQ号码已复制" Size:CGSizeMake(130, 70)];
    }];
    } else if (indexPath.row == 2) {
        alertAction = [UIAlertAction actionWithTitle:@"复制微信号: RFhzl1994" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
            pastboard.string = @"RFhzl1994";
            [self addPromptViewWithMessage:@"微信号已复制" Size:CGSizeMake(130, 70)];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertContorller addAction:alertAction];
    [alertContorller addAction:cancelAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view  addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
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
