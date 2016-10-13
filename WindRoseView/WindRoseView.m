//
//  DrawView.m
//  ContextRefDemo
//
//  Created by guixue0001 on 16/5/9.
//  Copyright © 2016年 klz. All rights reserved.
//

#import "WindRoseView.h"

#define LABEL_WIDTH  60
#define TIME_MAX 100

static CGFloat timeCount;

@implementation WindRoseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFromProperty];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadFromProperty];
    }
    return self;
}

- (void)loadFromProperty
{
    self.oldArr = [NSArray array];
    self.processArr = [NSArray array];
    self.isAnimated = YES;
    self.strokeColor = [UIColor whiteColor];
    self.inStrokeColor = [UIColor redColor];
    self.spotColor = [UIColor redColor];
    self.fillColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.300];
    self.inFillColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.300];
    self.lineWidth = 1.0;
}

- (void)setProgressArr:(NSArray *)progressArr
{
    if (_progressArr != progressArr) {
        _progressArr = progressArr;
        if (!self.oldArr.count || !_isAnimated) { //第一次加载或者关掉动画
            self.processArr = progressArr;
            self.oldArr = progressArr;
            [self setNeedsDisplay];
        } else //进度有变化
        {
            [self startTimer];
        }
    }
}

- (void)setNameArr:(NSArray *)nameArr
{
    if (_nameArr != nameArr) {
        _nameArr = nameArr;
        [self createLabels];
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    if (_strokeColor != strokeColor) {
        _strokeColor = strokeColor;
        [self setNeedsDisplay];
    }
}

- (void)setFillColor:(UIColor *)fillColor
{
    if (_fillColor != fillColor) {
        _fillColor = fillColor;
        [self setNeedsDisplay];
    }
}

- (void)setInStrokeColor:(UIColor *)inStrokeColor
{
    if (_inStrokeColor != inStrokeColor) {
        _inStrokeColor = inStrokeColor;
        [self setNeedsDisplay];
    }
}

- (void)setInFillColor:(UIColor *)inFillColor
{
    if (_inFillColor != inFillColor) {
        _inFillColor = inFillColor;
        [self setNeedsDisplay];
    }
}

- (void)setSpotColor:(UIColor *)spotColor
{
    if (_spotColor != spotColor) {
        _spotColor = spotColor;
        [self setNeedsDisplay];
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}

- (void)createLabels
{
    NSInteger sideCount = self.nameArr.count;
    CGFloat angle = 360.0/sideCount;
    CGFloat radius = self.frame.size.width/2 - LABEL_WIDTH/2;
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);

    for (int i = 0;i < self.nameArr.count; i ++) {
        CGPoint peakCenter = [self calcCircleCoordinateWithCenter:CGPointMake(center.x, center.y) andWithAngle:angle * i + 90 andWithRadius:radius];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(peakCenter.x - LABEL_WIDTH/2, peakCenter.y - LABEL_WIDTH/2, LABEL_WIDTH, LABEL_WIDTH)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = self.nameArr[i];
        [self addSubview:nameLabel];
    }
}

- (void)drawRect:(CGRect)rect
{
    NSInteger sideCount = self.processArr.count;
    CGFloat angle = 360.0/sideCount;
    CGFloat radius = self.frame.size.width/2 - LABEL_WIDTH;
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, self.lineWidth); //宽度
    CGPoint aPoints[sideCount + 1]; //顶点
    CGPoint bPoints[sideCount + 1]; //分数点
    
    if (sideCount > 0) {
        for (int i = 0; i < sideCount + 1; i ++) {
            CGFloat progress = [self.processArr[i%sideCount] floatValue];
            CGPoint spotCenter = [self calcCircleCoordinateWithCenter:CGPointMake(center.x, center.y) andWithAngle:angle * i + 90 andWithRadius:radius * progress];
            CGContextSetFillColorWithColor(context, self.spotColor.CGColor);
            CGContextAddArc(context, spotCenter.x, spotCenter.y, 2, 0, 2*M_PI, 0);
            CGContextDrawPath(context, kCGPathFill);
            
            
            aPoints[i] = [self calcCircleCoordinateWithCenter:CGPointMake(center.x, center.y) andWithAngle:angle * i + 90 andWithRadius:radius];
            bPoints[i] = spotCenter;
            if (i < sideCount) {
                CGPoint sPoints[2];
                sPoints[0] = CGPointMake(center.x, center.y);
                sPoints[1] = aPoints[i];
                
                CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
                CGContextAddLines(context, sPoints, 2);
                CGContextDrawPath(context, kCGPathStroke); //开始画线
            }
        }
//        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);//填充外圈颜色
//        CGContextAddLines(context, aPoints, sideCount + 1);
//        CGContextDrawPath(context, kCGPathFillStroke); //开始画线
        
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
        CGContextAddArc(context, center.x, center.y, radius, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGContextSetStrokeColorWithColor(context, self.inStrokeColor.CGColor);
        CGContextSetFillColorWithColor(context, self.inFillColor.CGColor);//填充内圈颜色
        CGContextAddLines(context, bPoints, sideCount + 1);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    }

}

- (void)startTimer
{
    timeCount = 0;
    [self.timer invalidate];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.timer=[NSTimer scheduledTimerWithTimeInterval:0.01
                                                        target:weakSelf
                                                      selector:@selector(changeProgress)
                                                      userInfo:nil
                                                       repeats:YES] ;
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)changeProgress
{
    if (timeCount < TIME_MAX) {
        timeCount ++;
        NSMutableArray *newArray = [NSMutableArray array];
        for (int i = 0; i < _progressArr.count; i++) {
            CGFloat oldProgress = 0;
            CGFloat progress = [_progressArr[i] floatValue];
            if (i < self.oldArr.count) {
                oldProgress = [self.oldArr[i] floatValue];
            }
            CGFloat changeProgress = (progress - oldProgress) * timeCount/TIME_MAX + oldProgress;
            [newArray addObject:[NSString stringWithFormat:@"%f",changeProgress]];
        }
        self.processArr = [NSArray arrayWithArray:newArray];
        [self setNeedsDisplay];
    } else
    {
        self.oldArr = _progressArr;
        [self.timer invalidate];
    }
}

-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint)center  andWithAngle: (CGFloat)angle andWithRadius: (CGFloat)radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}


@end
