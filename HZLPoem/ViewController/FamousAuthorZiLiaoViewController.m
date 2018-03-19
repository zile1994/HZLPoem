//
//  FamousAuthorZiLiaoViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/29.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "FamousAuthorZiLiaoViewController.h"
#import "ToolClass.h"
#import "PromptView.h"
#import "NoSearchResultView.h"
//#import "UMSocial.h"


#define kPromptViewSize  CGSizeMake(110, 70)
NSString * const CollectionAuthorPath = @"collectionAuthor.plist";

@interface FamousAuthorZiLiaoViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *ziliaoWebView;
@property (nonatomic, strong) NSString *collectionAuthorPath;
@property (nonatomic, strong) NSMutableArray *collectionAuthorArr;
@property (nonatomic, strong) NSString *collectionAuthor;
@property (nonatomic, strong) NoSearchResultView *noSearchResultView;
@property (nonatomic, strong) UIBarButtonItem *shareTabBarItem;

@end

@implementation FamousAuthorZiLiaoViewController

- (id)initFamousAuthorZilLiaoViewControllerWithZlid:(NSString *)zlid ziliaoTitlt:(NSString *)ziliaoTitle{
    if (self = [super init]) {
        self.zlid = zlid;
        self.ziliaoTitle = ziliaoTitle;
    }
    return self;
}

- (NSMutableArray *)collectionAuthorArr {
    if (!_collectionAuthorArr) {
        _collectionAuthorArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionAuthorPath];
        if (!_collectionAuthorArr) {
            _collectionAuthorArr = @[].mutableCopy;
        }
    }
    return _collectionAuthorArr;
}

- (void)initZiliaoWebView {
    self.ziliaoWebView = [[UIWebView alloc] init];
    [self.view addSubview:self.ziliaoWebView];
    self.ziliaoWebView.backgroundColor = kRGBColor(245, 245, 245);
    self.ziliaoWebView.delegate = self;
    [self.ziliaoWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.author.ziliao.show.api.php?zlid=%@", self.zlid];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.ziliaoWebView loadRequest:request];
}

- (void)initNoSearchResultView {
    self.noSearchResultView = [[NoSearchResultView alloc] init];
    self.noSearchResultView.noResultLabel.text = @"请检查您的网络设置";
}

- (void)initShareTabBarItem {
    self.shareTabBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAuthor)];
    self.navigationItem.rightBarButtonItem = self.shareTabBarItem;
}

//- (void)shareAuthor {
//    UIImage *image = [UIImage imageNamed:@"aboutusicon"];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56eb5eb167e58e5b7a0020a0" shareText:[NSString stringWithFormat:@"我正在诗词古韵里看%@的详细信息呢,你快来吧", self.collectionAuthor] shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToEmail,UMShareToQQ, UMShareToQzone,nil] delegate:self];
//}

- (void)initCollectionAuthorPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.collectionAuthorPath]) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        self.collectionAuthorPath = [path stringByAppendingPathComponent:CollectionAuthorPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.ziliaoTitle;
    [self initShareTabBarItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNoSearchResultView];
    [self initZiliaoWebView];
    [self initCollectionAuthorPath];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collectionAuthor = [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('author').value"];
    [self.collectionAuthorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.collectionAuthor isEqualToString:obj]) {
            [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmarkauthor').text = '已收藏'"];
        }
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.collectionAuthor = [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('author').value"];
    [self.collectionAuthorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.collectionAuthor isEqualToString:obj]) {
            [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmarkauthor').text = '已收藏'"];
        }
    }];
}

- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *scheme = request.URL.scheme;
    NSString *text = [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmarkauthor').text"];
    if (navigationType == UIWebViewNavigationTypeLinkClicked && [scheme isEqualToString:@"bookmarkauthor"]) {
        if ([text isEqualToString:@"收藏"]) {
            [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmarkauthor').text = '已收藏'"];
            [self.collectionAuthorArr addObject:self.collectionAuthor];
            [self addPromptViewWithMessage:@"已加入收藏" Size:kPromptViewSize];
        } else if ([text isEqualToString:@"已收藏"]) {
            [self.ziliaoWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmarkauthor').text = '收藏'"];
            [self.collectionAuthorArr removeObject:self.collectionAuthor];
            [self addPromptViewWithMessage:@"已取消收藏" Size:kPromptViewSize];
        }
        [ToolClass archivedOfObject:self.collectionAuthorArr toPath:self.collectionAuthorPath];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
