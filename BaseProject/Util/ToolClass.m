//
//  ToolClass.m
//  BaseProject
//
//  Created by 黄子乐 on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

+ (PromptView *)setPromptViewWithMessage:(NSString *)message {
    PromptView *promptView = [[PromptView alloc] init];
    promptView.layer.cornerRadius = 10;
    promptView.layer.masksToBounds = YES;
    promptView.promptLabel.text = message;
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        promptView.alpha = 0;
    } completion:^(BOOL finished) {
        [promptView removeFromSuperview];
    }];
    return promptView;
}

+ (PoemsTableViewHeadView *)setPoemsTableHeadViewWithFrame:(CGRect)frame PoemImageName:(NSString *)imageName BackgroundColor:(UIColor *)color JianjieLabelText:(NSString *)jianjie {
    PoemsTableViewHeadView *poemsTableViewHV = [[PoemsTableViewHeadView alloc] init];
    poemsTableViewHV.frame = frame;
    poemsTableViewHV.poemImageView.image = [UIImage imageNamed:imageName];
    poemsTableViewHV.backgroundColor = color;
    poemsTableViewHV.jianjieLabel.text = jianjie;
    return poemsTableViewHV;
}

+ (void)archivedOfObject:(id)object toPath:(NSString *)path {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSError *error = nil;
    BOOL flag = [data writeToFile:path options:NSDataWritingAtomic error:&error];
    if (!flag) {
        NSLog(@"%@", error.userInfo);
    }
}

+ (void)toSettingNetWork {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
}

+ (NSString *)unsimplifiedExchangeToSimplified:(NSString *)string {
    NSString *str;
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        str = string;
    } else {
        str = [string stringByApplyingTransform:@"Hant-Hans" reverse:NO];
    }
    return str;
}

/**计算文本高度*/
+ (CGFloat)calculateHeightOfString:(NSString *)string ConstraintSize:(CGSize)ConstraintSize AttributeDic:(NSDictionary *)attributeDic {
    CGSize  size = [string boundingRectWithSize:ConstraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:nil].size;
    return size.height;
}

+ (UIButton *)setButtonWithTitlt:(NSString *)title BackgroundColor:(UIColor *)backgroundColor TitleColor:(UIColor *)titleColor frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    return button;
}

+ (UILabel *)setPeekHeadLabelWithTitle:(NSString *)title BackgroundColor:(UIColor *)backgroundColor TitltColor:(UIColor *)titleColor {
    UILabel *label =[[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = backgroundColor;
    label.textColor = titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
