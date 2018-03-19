
//
//  GelvjiDetailViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/4/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "GelvjiDetailViewController.h"
#import "ToolClass.h"
#import "GelvjiDetailCell.h"
#import "CollectionGelv.h"


#define kHomeTableViewCell  @"homeTableViewCell"
NSString * const CollectionGelvPath = @"collectionGelv.plist";

@interface GelvjiDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) UIView *gelvjiDetailHomeView;
@property (nonatomic, strong) UITextView *introTextView;
@property (nonatomic, assign) CGFloat introTextViewHeight;
@property (nonatomic, strong) UITextView *anaotetaTextView;
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) NSArray *poemArr;
@property (nonatomic, strong) UIWebView *footerWebView;
@property (nonatomic, strong) NSMutableArray *collectionGelvArr;
@property (nonatomic, strong) NSString *collectionGelvPath;

@end

@implementation GelvjiDetailViewController

- (id)initGelvjiDetailViewControllerWithName:(NSString *)name NameDetail:(NSString *)nameDetail Intro:(NSString *)intro Sample:(NSString *)sample MelodyNote:(NSString *)melodyNote {
    if (self = [super init]) {
        self.name = name;
        self.nameDetail = nameDetail;
        self.intro = intro;
        self.sample = sample;
        self.melodyNote = melodyNote;
    }
    return self;
}
- (void)initCollectionGelvPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.collectionGelvPath]) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        self.collectionGelvPath = [path stringByAppendingPathComponent:CollectionGelvPath];
    }
}

- (void)initCollectionGelvArr {
    if (!self.collectionGelvArr) {
        self.collectionGelvArr = [NSMutableArray array];
        self.collectionGelvArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionGelvPath];
        if (!self.collectionGelvArr) {
            self.collectionGelvArr = @[].mutableCopy;
        }
    }
}

- (void)initCollectionShilvBarBtn {
    UIButton *button = [ToolClass setButtonWithTitlt:@"收藏" BackgroundColor:[UIColor clearColor] TitleColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 40, 30)];
    [button addTarget:self action:@selector(toCollectionGelv) forControlEvents:UIControlEventTouchUpInside];
    self.collectionShilvBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)initCancelCollectionShilvBarBtn {
    UIButton *button = [ToolClass setButtonWithTitlt:@"已收藏" BackgroundColor:[UIColor clearColor] TitleColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 60, 30)];
    [button addTarget:self action:@selector(toCancelCollectionGelv) forControlEvents:UIControlEventTouchUpInside];
    self.cancelCollectionShilvBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)toCollectionGelv {
    self.navigationItem.rightBarButtonItem = self.cancelCollectionShilvBarBtn;
    CollectionGelv *gelv = [[CollectionGelv alloc] initGelvjiDetailViewControllerWithName:self.name NameDetail:self.nameDetail Intro:self.intro Sample:self.sample MelodyNote:self.melodyNote];
    [self.collectionGelvArr addObject:gelv];
    [ToolClass archivedOfObject:self.collectionGelvArr toPath:self.collectionGelvPath];
    [self addPromptViewWithMessage:@"已收藏" Size:CGSizeMake(110, 70)];
}

- (void)toCancelCollectionGelv {
    self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
    __weak typeof(self)  _self = self;
    [self.collectionGelvArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectionGelv *gelv = obj;
        if ([gelv.name isEqualToString:self.name] && [gelv.nameDetail isEqualToString:self.nameDetail]) {
            [_self.collectionGelvArr removeObject:obj];
        }
    }];
    [ToolClass archivedOfObject:self.collectionGelvArr toPath:self.collectionGelvPath];
    [self addPromptViewWithMessage:@"已取消收藏" Size:CGSizeMake(110, 70)];
}

- (void)initIntroTextView {
    CGSize introConstraintSize = CGSizeMake(kWidth - 20, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.paragraphSpacing = 20;
    NSDictionary *introAttributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: kRGBColor(50, 50, 50), NSParagraphStyleAttributeName: paragraphStyle};
    NSString *str = @"    ";
    NSString *introString = [str stringByAppendingString:self.intro];
    self.introTextViewHeight = [ToolClass calculateHeightOfString:introString ConstraintSize:introConstraintSize AttributeDic:introAttributeDic];
    self.introTextView = [[UITextView alloc] init];
    self.introTextView.scrollEnabled = NO;
    self.introTextView.editable = NO;
    self.introTextView.userInteractionEnabled = YES;
    self.introTextView.backgroundColor = [UIColor clearColor];
    self.introTextView.attributedText = [[NSAttributedString alloc] initWithString:introString attributes:introAttributeDic];
    self.introTextView.frame = CGRectMake(0, 0, kWidth, self.introTextViewHeight - 5);
}

- (void)initAnaotateTextView {
    CGSize anaotateConstraintSize = CGSizeMake(kWidth - 20, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.paragraphSpacing = 20;
    NSString *str1 = [self.melodyNote stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    NSDictionary *anaotateAttributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor grayColor], NSParagraphStyleAttributeName: paragraphStyle};
    CGFloat anaotateTextViewHeight = [ToolClass calculateHeightOfString:str1 ConstraintSize:anaotateConstraintSize AttributeDic:anaotateAttributeDic];
    self.anaotetaTextView = [[UITextView alloc] init];
    self.anaotetaTextView.backgroundColor = [UIColor clearColor];
    self.anaotetaTextView.scrollEnabled = NO;
    self.anaotetaTextView.attributedText = [[NSAttributedString alloc] initWithString:str1 attributes:anaotateAttributeDic];
    self.anaotetaTextView.frame = CGRectMake(0, 0, kWidth, anaotateTextViewHeight);
}

- (void)initPoemArr {
    NSString *str1 = [self.sample stringByReplacingOccurrencesOfString:@"<br />" withString:@"\r\n"];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\r\n"];
    self.poemArr = [str2 componentsSeparatedByString:@"\r\n"];
}

- (void)initHomeTableView {
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.separatorStyle = NO;
    self.homeTableView.showsVerticalScrollIndicator = NO;
    self.homeTableView.tableFooterView = self.footerWebView;
    self.homeTableView.tableHeaderView = self.introTextView;
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.homeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHomeTableViewCell];
    
}

- (void)initWebView {
    self.footerWebView = [[UIWebView alloc] init];
    self.footerWebView.delegate = self;
    self.footerWebView.scrollView.bounces = NO;
    self.footerWebView.frame = CGRectMake(10, 10, kWidth - 20, 0);
    [self.footerWebView loadHTMLString:self.melodyNote baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *height_str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    CGFloat height = [height_str floatValue];
    self.footerWebView.frame = CGRectMake(10, 10, kWidth - 20, height + 10);
    self.homeTableView.tableFooterView = self.footerWebView;
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    [self initCollectionGelvPath];
    [self initCollectionGelvArr];
    [self initCollectionShilvBarBtn];
    [self initCancelCollectionShilvBarBtn];
    [self initIntroTextView];
    [self initWebView];
    [self initAnaotateTextView];
    [self initPoemArr];
    [self initHomeTableView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCollectionGelvArr];
    NSInteger count = self.collectionGelvArr.count;
    if (count == 0) {
        self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
    } else {
        for (NSInteger i = 0 ; i < count; i++) {
            CollectionGelv *gelv = self.collectionGelvArr[i];
            if ([gelv.name isEqualToString:self.name] && [gelv.nameDetail isEqualToString:self.nameDetail]) {
                self.navigationItem.rightBarButtonItem = self.cancelCollectionShilvBarBtn;
                break;
            } else {
                self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
      return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.poemArr.count - 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeTableViewCell];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.poemArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertControllr = [UIAlertController alertControllerWithTitle:@"" message:self.poemArr[indexPath.row] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = self.poemArr[indexPath.row];
        [self addPromptViewWithMessage:@"诗文已复制" Size:CGSizeMake(150, 70)];
    }];
    [alertControllr addAction:cancelAction];
    [alertControllr addAction:copyAction];
    [self.navigationController presentViewController:alertControllr animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"范例";
    } else {
        return @"注释";
    }
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
