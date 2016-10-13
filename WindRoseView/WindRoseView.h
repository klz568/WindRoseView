//
//  DrawView.h
//  ContextRefDemo
//
//  Created by guixue0001 on 16/5/9.
//  Copyright © 2016年 klz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindRoseView : UIView

@property (nonatomic, strong) NSTimer *timer;
//当前数组
@property (nonatomic, copy) NSArray *oldArr;
//动画进行时数组
@property (nonatomic, copy) NSArray *processArr;

//顶点标题
@property (nonatomic, copy) NSArray *nameArr;
//最新数组
@property (nonatomic, copy) NSArray *progressArr;
//是否开启动画
@property (nonatomic, assign) BOOL isAnimated;
//外围线颜色
@property (nonatomic, copy) UIColor *strokeColor;
//外围背景色
@property (nonatomic, copy) UIColor *fillColor;
//内围线的顶点色
@property (nonatomic, copy) UIColor *spotColor;
//内围先颜色
@property (nonatomic, copy) UIColor *inStrokeColor;
//内围背景色
@property (nonatomic, copy) UIColor *inFillColor;
//线条宽度
@property (nonatomic, assign) CGFloat lineWidth;

@end
