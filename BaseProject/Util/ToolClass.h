//
//  ToolClass.h
//  BaseProject
//
//  Created by 黄子乐 on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PromptView.h"
#import "PoemsTableViewHeadView.h"

@interface ToolClass : NSObject

/**添加提示视图*/
+ (PromptView *)setPromptViewWithMessage: (NSString *)message;

/**添加tableHeadView*/
+ (PoemsTableViewHeadView *)setPoemsTableHeadViewWithFrame:(CGRect)frame PoemImageName:(NSString *)imageName BackgroundColor:(UIColor *)color JianjieLabelText:(NSString *)jianjie;

/**归档*/
+ (void)archivedOfObject:(id)object toPath:(NSString *)path;

/**设置网络*/
+ (void)toSettingNetWork;

/**繁体字转简体字*/
+ (NSString *)unsimplifiedExchangeToSimplified:(NSString *)string;

/**计算文本高度*/
+ (CGFloat)calculateHeightOfString:(NSString *)string ConstraintSize:(CGSize)ConstraintSize AttributeDic:(NSDictionary *)attributeDic;

/**创建button*/
+ (UIButton *)setButtonWithTitlt:(NSString *)title BackgroundColor:(UIColor *)backgroundColor TitleColor:(UIColor *)titleColor frame:(CGRect)frame;

/**创建Peek状态下的头部标签*/
+ (UILabel *)setPeekHeadLabelWithTitle:(NSString *)title BackgroundColor:(UIColor *)backgroundColor TitltColor:(UIColor *)titleColor;

@end
