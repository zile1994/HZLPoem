//
//  PoemCommonSenseDetailViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemCommonSenseDetailViewController.h"
#import "PoemCommonSenseDetailViewModel.h"
#import "GelvjiDetailCell.h"
#import "ToolClass.h"

@interface PoemCommonSenseDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *homeWebView;
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) PoemCommonSenseDetailViewModel *poemCommonSenseDetailVM;

@end

@implementation PoemCommonSenseDetailViewController

- (void)initPoemCommonSenseDetailViewModel {
    self.poemCommonSenseDetailVM = [[PoemCommonSenseDetailViewModel alloc] initPoemCommonSenseDatailViewModelWithFID:self.fid];
}

- (void)initHomeWebView {
    self.homeWebView = [[UIWebView alloc] init];
    self.homeWebView.backgroundColor = [UIColor whiteColor];
    self.homeWebView.delegate = self;
    [self.view addSubview:self.homeWebView];
    [self.homeWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).with.offset(5);
        make.bottom.right.mas_equalTo(self.view);
    }];
    __weak typeof(self) _self = self;
    [self.poemCommonSenseDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
        if (error) {
            [_self showErrorMsg:error.localizedDescription];
        } else {
            NSString *str = [ToolClass unsimplifiedExchangeToSimplified:[self.poemCommonSenseDetailVM getAnswerForRow:0]];
            [_self.homeWebView loadHTMLString:str baseURL:nil];
        }
    }];
    
}

- (id)initPoemCommonSenseDetailViewControllerWithFID:(NSString *)fid Question:(NSString *)question {
    if (self = [super init]) {
        self.fid = fid;
        self.question = question;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.question;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPoemCommonSenseDetailViewModel];
    [self initHomeWebView];
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '120%'";
    [self.homeWebView stringByEvaluatingJavaScriptFromString:str];
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
