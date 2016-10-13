//
//  ViewController.m
//  WindRoseDemo
//
//  Created by guixue0001 on 16/10/13.
//  Copyright © 2016年 guixue0001. All rights reserved.
//

#import "ViewController.h"
#import "WindRoseView.h"

@interface ViewController ()

@property (nonatomic, strong) WindRoseView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _drawView = [[WindRoseView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width)/2, self.view.frame.size.width, self.view.frame.size.width)];
    self.drawView.backgroundColor = [UIColor colorWithRed:0.118 green:0.145 blue:0.169 alpha:1.000];
    self.drawView.nameArr = @[@"智力",@"力量",@"速度",@"法力",@"血量",@"更多"];
    self.drawView.progressArr = @[@0.3,@0.9,@0.4,@0.5,@0.7,@0.3];
    [self.view addSubview:self.drawView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 30)];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(reloadDraw) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateHighlighted];
    [self.view addSubview:button];
}

- (void)reloadDraw
{
    [self change];
    NSMutableArray *reloadArr = [NSMutableArray array];
    for (int i = 0; i < self.drawView.progressArr.count; i ++) {
        CGFloat progress = arc4random()%11 * 0.1;
        [reloadArr addObject:[NSNumber numberWithFloat:progress]];
    }
    self.drawView.progressArr = reloadArr;
}

- (void)change
{
    self.drawView.strokeColor = [UIColor colorWithRed:arc4random()%1001 * 0.001 green:arc4random()%1001 * 0.001 blue:arc4random()%1001 * 0.001 alpha:1.000];
    self.drawView.inStrokeColor = [UIColor colorWithRed:arc4random()%1001 * 0.001 green:arc4random()%1001 * 0.001 blue:arc4random()%1001 * 0.001 alpha:1.000];
    self.drawView.spotColor = self.drawView.inStrokeColor;
    self.drawView.fillColor = [UIColor colorWithRed:arc4random()%1001 * 0.001 green:arc4random()%1001 * 0.001 blue:arc4random()%1001 * 0.001 alpha:0.300];
    self.drawView.inFillColor = [UIColor colorWithRed:arc4random()%1001 * 0.001 green:arc4random()%1001 * 0.001 blue:arc4random()%1001 * 0.001 alpha:0.300];
    self.drawView.lineWidth = arc4random()%20*0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
