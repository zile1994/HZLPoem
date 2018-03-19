//
//  PoemDetailViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemDetailViewController.h"
#import "FamousAuthorDetailViewController.h"
#import "CollectionPoemViewController.h"
#import "CollectionPoem.h"
#import "ToolClass.h"
#import "PromptView.h"
//#import "UMSocial.h"
#import "NoSearchResultView.h"
#import "PoemDetailShanxiViewController.h"

#define kPromptViewSize  CGSizeMake(150, 70)
NSString * const CollectionPoemPath = @"collectionPoem.plist";

@interface PoemDetailViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *poemWebView;
@property (nonatomic, strong) NSString *collectionTitle;
@property (nonatomic, strong) NSString *collectionAuthorName;
@property (nonatomic, strong) NSString *collectionViewId;
@property (nonatomic, strong) NSMutableArray *collectionPoemArr;
@property (nonatomic, strong) NSString *collectionAuthor;
@property (nonatomic, strong) NSString *collectionPoemPath;
@property (nonatomic, strong) UIBarButtonItem *shareBarItem;

@end

@implementation PoemDetailViewController


- (void)initPoemwebView {
    self.poemWebView = [[UIWebView alloc] init];
    self.poemWebView.delegate = self;
    self.poemWebView.backgroundColor = kRGBColor(245, 245, 245);
    [self.view addSubview:self.poemWebView];
    [self.poemWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSString *path = [NSString stringWithFormat:@"http://iapi.ipadown.com/api/gushiwen/gushiwen.view.show.api.php?viewid=%@", self.viewid];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.poemWebView loadRequest:request];
}

- (void)setCollectionPoemArr {
    self.collectionPoemArr = [NSMutableArray array];
    self.collectionPoemArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionPoemPath];
    if (!_collectionPoemArr) {
        _collectionPoemArr = @[].mutableCopy;
    }
}

//- (void)initShareBarItem {
//    self.shareBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareDetail)];
//    self.navigationItem.rightBarButtonItem = self.shareBarItem;
//}

//- (void)shareDetail {
//    UIImage *image = [UIImage imageNamed:@"aboutusicon"];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56eb5eb167e58e5b7a0020a0" shareText:[NSString stringWithFormat:@"我正在诗词古韵里看%@,你快来吧", self.poemTitle] shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToEmail,UMShareToQQ, UMShareToQzone,nil] delegate:self];
//}

- (id)initPoemDetailControllerWithViewid:(NSString *)viewid PoemTitle:(NSString *)poemTitle AuthorId:(NSString *)authorId AuthorName:(NSString *)authorName {
    if (self = [super init]) {
        self.viewid = viewid;
        self.poemTitle = poemTitle;
        self.authorId = authorId;
        self.authorName = authorName;
    }
    return self;
}

- (id)initPoemDetailControllerWithViewid:(NSString *)viewid PoemTitle:(NSString *)poemTitle AuthorName:(NSString *)authorName{
    if (self = [super init]) {
        self.viewid = viewid;
        self.poemTitle = poemTitle;
        self.authorName = authorName;
    }
    return self;
}

- (void)initCollectionPoemPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.collectionPoemPath]) {
        NSString *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        self.collectionPoemPath = [filepath stringByAppendingPathComponent:CollectionPoemPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.poemTitle;
//    [self initShareBarItem];
    [self initPoemwebView];
    [self initCollectionPoemPath];
    [self setCollectionPoemArr];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionPoemArr removeAllObjects];
    [self setCollectionPoemArr];
    [self.collectionPoemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectionPoem *poem = obj;
        if ([self.poemTitle isEqualToString:poem.title]) {
            [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '已收藏'"];
        } else {
             [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '收藏'"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.collectionTitle = [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title').value"];
    self.collectionViewId = [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('viewid').value"];
    self.collectionAuthor = [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('author').value"];
    [self.collectionPoemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectionPoem *poem = obj;
        if ([self.poemTitle isEqualToString:poem.title]) {
            [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '已收藏'"];
        }
    }];
    [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('tips')[0].style.display = 'none'"];
    [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('tips')[1].style.display = 'none'"];
    [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_SSP__wrapper_u2545915_0').style.display = 'none'"];
    [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_SSP__wrapper_u2545930_0').style.display = 'none'"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *scheme = request.URL.scheme;
    if (navigationType == UIWebViewNavigationTypeLinkClicked && [scheme isEqualToString:@"authorid"]) {
        FamousAuthorDetailViewController *famousAuthorDetailVC;
        if (self.authorId && self.authorName) {
             famousAuthorDetailVC = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorId:self.authorId AuthorName:self.authorName];
        } else if (self.authorName) {
            famousAuthorDetailVC = [[FamousAuthorDetailViewController alloc] initAuthorDetailViewControllrtWithAuthorName:self.authorName];
        } else {
            [self addPromptViewWithMessage:@"请返回上一层查看" Size:kPromptViewSize];
        }
        [self.navigationController pushViewController:famousAuthorDetailVC animated:YES];
        return NO;
    } else if (navigationType == UIWebViewNavigationTypeLinkClicked && [scheme isEqualToString:@"bookmark"]) {
        
        /**初始化归档诗文对象*/
        CollectionPoem *poem = [[CollectionPoem alloc] initCollectionPoemWithTitle:self.collectionTitle Author:self.collectionAuthor Viewid:self.collectionViewId];
        NSString *text = [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text"];
        /**弹出视图显示已收藏或者取消收藏*/
        if ([text isEqualToString:@"收藏"]) {
         [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '已收藏'"];
            [self addPromptViewWithMessage:@"已加入收藏" Size:kPromptViewSize];
            [self.collectionPoemArr addObject:poem];
        } else if ([text isEqualToString:@"已收藏"]) {
            [self.poemWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '收藏'"];
            [self addPromptViewWithMessage:@"已取消收藏" Size:kPromptViewSize];

            __weak typeof(self) _self = self;
            [self.collectionPoemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CollectionPoem *poem = obj;
                if ([poem.title isEqualToString:_self.collectionTitle]) {
                    [_self.collectionPoemArr removeObject:obj];
                }
            }];
        }
        /**将收藏的诗文对象归档存储进沙盒*/
        [ToolClass archivedOfObject:self.collectionPoemArr toPath:self.collectionPoemPath];
    } else if (navigationType == UIWebViewNavigationTypeLinkClicked){
        NSLog(@"url = %@", request.URL);
        /**跳转至诗文赏析界面*/
        PoemDetailShanxiViewController *poemDetailShanxiVC = [[PoemDetailShanxiViewController alloc] initPoemDetailShanxiViewControllerWithRequest:request poemTitle:self.poemTitle];
        [self.navigationController pushViewController:poemDetailShanxiVC animated:YES];
        return NO;
    }
    return YES;
}

- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
}

@end
