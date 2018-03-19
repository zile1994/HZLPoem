//
//  PoemDetailShanxiViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/5/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PoemDetailShanxiViewController.h"
#import "PromptView.h"
#import "ToolClass.h"
#import "CollectionPoem.h"
//#import "UMSocial.h"

extern NSString * const CollectionPoemPath;
#define kPromptViewSize  CGSizeMake(150, 70)

@interface PoemDetailShanxiViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *poemDetailShanxiWebView;
@property (nonatomic, strong) NSString *collectionTitle;
@property (nonatomic, strong) NSString *collectionAuthor;
@property (nonatomic, strong) NSString *collectionViewId;
@property (nonatomic, strong) NSMutableArray *collectionPoemArr;
@property (nonatomic, strong) NSString *collectionPoemPath;
@property (nonatomic, strong) UIBarButtonItem *shareBarItem;

@end

@implementation PoemDetailShanxiViewController

- (id)initPoemDetailShanxiViewControllerWithRequest:(NSURLRequest *)request poemTitle:(NSString *)poemTitle {
    if (self = [super init]) {
        self.request = request;
        self.poemTitle = poemTitle;
    }
    return self;
}

- (void)initPoemDetailShanxiWebView {
    self.poemDetailShanxiWebView = [[UIWebView alloc] init];
    self.poemDetailShanxiWebView.backgroundColor = kRGBColor(245, 245, 245);
    self.poemDetailShanxiWebView.delegate = self;
    [self.view addSubview:self.poemDetailShanxiWebView];
    [self.poemDetailShanxiWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.poemDetailShanxiWebView loadRequest:self.request];
}

- (NSMutableArray *)collectionPoemArr {
    if (!_collectionPoemArr) {
        _collectionPoemArr = [NSMutableArray array];
        _collectionPoemArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionPoemPath];
        if (!_collectionPoemArr) {
            _collectionPoemArr = @[].mutableCopy;
        }
    }
    return _collectionPoemArr;
}

- (void)initCollectionPoemPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.collectionPoemPath]) {
        NSString *filepath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        self.collectionPoemPath = [filepath stringByAppendingPathComponent:CollectionPoemPath];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.collectionTitle = [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title').value"];
    self.collectionViewId = [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('viewid').value"];
    self.collectionAuthor = [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('author').value"];
    [self.collectionPoemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectionPoem *poem = obj;
        if ([self.poemTitle isEqualToString:poem.title]) {
            [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '已收藏'"];
        }
    }];
}

//- (void)initShareBarItem {
//    self.shareBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareDetail)];
//    self.navigationItem.rightBarButtonItem = self.shareBarItem;
//}

//- (void)shareDetail {
//    UIImage *image = [UIImage imageNamed:@"aboutusicon"];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56eb5eb167e58e5b7a0020a0" shareText:[NSString stringWithFormat:@"我正在诗词古韵里看%@,你快来吧", self.poemTitle] shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToEmail,UMShareToQQ, UMShareToQzone,nil] delegate:self];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@鉴赏", self.poemTitle];
    [self initPoemDetailShanxiWebView];
//    [self initShareBarItem];
    [self initCollectionPoemPath];
    // Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *scheme = request.URL.scheme;
    if (navigationType == UIWebViewNavigationTypeLinkClicked && [scheme isEqualToString:@"bookmark"]) {
        CollectionPoem *poem = [[CollectionPoem alloc] initCollectionPoemWithTitle:self.collectionTitle Author:self.collectionAuthor Viewid:self.collectionViewId];
        NSString *text = [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text"];
        if ([text isEqualToString:@"收藏"]) {
            [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '已收藏'"];
            [self addPromptViewWithMessage:@"已加入收藏" Size:kPromptViewSize];
            [self.collectionPoemArr addObject:poem];
        } else if ([text isEqualToString:@"已收藏"]) {
            [self.poemDetailShanxiWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('bookmark').text = '收藏'"];
            [self addPromptViewWithMessage:@"已取消收藏" Size:kPromptViewSize];
            __weak typeof(self) _self = self;
            [self.collectionPoemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CollectionPoem *poem = obj;
                if ([poem.title isEqualToString:_self.collectionTitle]) {
                    [_self.collectionPoemArr removeObject:obj];
                }
            }];
        }
        [ToolClass archivedOfObject:self.collectionPoemArr toPath:self.collectionPoemPath];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPromptViewWithMessage: (NSString *)message Size:(CGSize)size {
    PromptView *promptView = [ToolClass setPromptViewWithMessage:message];
    [self.view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
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
