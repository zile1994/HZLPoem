//
//  ChineseRhymeDetailViewController.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ChineseRhymeDetailViewController.h"
#import "SelectedButton.h"
#import "ToolClass.h"
#import "CollectionRhyme.h"
#import "PromptView.h"


NSString * const CollectionRhymePath = @"collectionRhyme.plist";

@interface ChineseRhymeDetailViewController ()

@property (nonatomic, strong) UIView *homeView;
@property (nonatomic, strong) UILabel *rhymeLabel;
@property (nonatomic, strong) UITextView *rhyContentTextView;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *collectionRhymeArr;
@property (nonatomic, strong) NSString *collectionRhymePath;

@end

@implementation ChineseRhymeDetailViewController

- (id)initChineseRhymeDetailViewControllerWithRhyHead:(NSString *)rhyHead rhyMother:(NSString *)rhyMother RhyContent:(NSString *)rhyContent {
    if (self = [super init]) {
        self.rhyHead = rhyHead;
        self.rhyMother = rhyMother;
        self.rhyContent = rhyContent;
    }
    return self;
}

- (void)initCollectionRhymePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.collectionRhymePath]) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        self.collectionRhymePath = [path stringByAppendingPathComponent:CollectionRhymePath];
    }
}

- (void)initCollectionRhymeArr {
    if (!self.collectionRhymeArr) {
        self.collectionRhymeArr = [NSMutableArray array];
        self.collectionRhymeArr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.collectionRhymePath];
        if (!self.collectionRhymeArr) {
            self.collectionRhymeArr = @[].mutableCopy;
        }
    }
}

- (void)initHomeView {
    self.homeView = [[UIView alloc] init];
    self.homeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.homeView];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.rhymeLabel = [[UILabel alloc] init];
    self.rhymeLabel.textAlignment = NSTextAlignmentCenter;
    self.rhymeLabel.font = [UIFont boldFlatFontOfSize:17];
    self.rhymeLabel.backgroundColor = [UIColor clearColor];
    self.rhymeLabel.text = self.rhyMother;
    self.rhymeLabel.textColor = [UIColor blackColor];
    self.rhymeLabel.numberOfLines = 0;
    [self.homeView addSubview:self.rhymeLabel];
    [self.rhymeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.homeView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.homeView.mas_right).with.offset(-30);
    }];
    [self.view setNeedsLayout];
   
    self.rhyContentTextView = [[UITextView alloc] init];
    self.rhyContentTextView.editable = NO;
    self.rhyContentTextView.textAlignment = NSTextAlignmentLeft;
    self.rhyContentTextView.backgroundColor = [UIColor clearColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:18],NSForegroundColorAttributeName: kRGBColor(50, 50, 50),NSParagraphStyleAttributeName: paragraphStyle};
    self.content = [self.rhyContent stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    self.rhyContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.content attributes:dic];
    [self.homeView addSubview:self.rhyContentTextView];
    [self.rhyContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rhymeLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.homeView.mas_left).with.offset(10);
        make.right.mas_equalTo(self.homeView.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(self.homeView.mas_bottom);
    }];
}

- (void)initCollectionShilvBarBtn {
    UIButton *button = [ToolClass setButtonWithTitlt:@"收藏" BackgroundColor:[UIColor clearColor] TitleColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 45, 30)];
    self.collectionShilvBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(toCollectionShilv) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toCollectionShilv {
    self.navigationItem.rightBarButtonItem = self.cancelCollectionShilvBarBtn;
    CollectionRhyme *rhyme = [[CollectionRhyme alloc] initCollectionRhymeWithRhyHead:self.rhyHead rhyMother:self.rhyMother rhyContent:self.rhyContent];
    [self.collectionRhymeArr addObject:rhyme];
    [ToolClass archivedOfObject:self.collectionRhymeArr toPath:self.collectionRhymePath];
    [self addPromptViewWithMessage:@"已收藏" Size:CGSizeMake(110, 70)];
}

- (void)initCancelCollectionShiliBarBtn {
    UIButton *button = [ToolClass setButtonWithTitlt:@"已收藏" BackgroundColor:[UIColor clearColor] TitleColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 60, 30)];
    [button addTarget:self action:@selector(toCancelCollectionShilv) forControlEvents:UIControlEventTouchUpInside];
    self.cancelCollectionShilvBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)toCancelCollectionShilv {
    self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
    __weak typeof(self) _self = self;
    [self.collectionRhymeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CollectionRhyme *collectonRhyme = obj;
        if ([collectonRhyme.rhyHead isEqualToString:self.rhyHead]) {
            [_self.collectionRhymeArr removeObject:obj];
        }
    }];
    [ToolClass archivedOfObject:self.collectionRhymeArr toPath:self.collectionRhymePath];
    [self addPromptViewWithMessage:@"已取消收藏" Size:CGSizeMake(110, 70)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.rhyHead;
    [self initCollectionRhymePath];
    [self initCollectionRhymeArr];
    [self initCollectionShilvBarBtn];
    [self initCancelCollectionShiliBarBtn];
    [self initHomeView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCollectionRhymeArr];
    NSInteger count = self.collectionRhymeArr.count;
    if (count == 0) {
        self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
    } else {
        for (NSInteger i = 0; i < count; i ++) {
            CollectionRhyme *rhyme = self.collectionRhymeArr[i];
            if ([rhyme.rhyHead isEqualToString:self.rhyHead]) {
                self.navigationItem.rightBarButtonItem = self.cancelCollectionShilvBarBtn;
                break;
            } else {
                self.navigationItem.rightBarButtonItem = self.collectionShilvBarBtn;
            }
        }
    }
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
