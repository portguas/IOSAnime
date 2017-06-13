//
//  CircleLayer.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/5/23.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>

typedef enum MovingPoint {
    POINT_D,
    POINT_B,
} MovingPoint;
#define outsideRectSize 90   //外部矩形的宽高

@interface CircleLayer()

@property (assign, nonatomic) CGRect outsideRect; // 外部矩形的位置
@property (assign, nonatomic) MovingPoint movePoint;

@end
@implementation CircleLayer

- (instancetype)init {
    self = [super init];
    if (self) {
//        statements
    }
    
    return self;
}


- (void)drawInContext:(CGContextRef)ctx {
    
    // outsideRect的位置确定了 我们就可以计算以这个矩形为基础的关键点
    // ABCD这四个点和对应的控制点的水平或者垂直距离.当offSet设置为 直径除以3.6 的时候，弧线能完美地贴合成圆弧
    CGFloat offset = self.outsideRect.size.width / 3.6;
    // ABCD移动的距离 自定义
    CGFloat movedDistance = self.outsideRect.size.width * 1/6 *fabs(self.progress - 0.5)*2;
    
    // 计算出外接矩形的中心点
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + outsideRectSize/2, self.outsideRect.origin.y + outsideRectSize/2);
    
    // 计算每个点的位置
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    
    CGPoint pointB;
    CGPoint pointD;
    // 往左移动
    if (self.movePoint == POINT_B) {
        // B点移动的距离 * 2 这样更加明显
        pointB = CGPointMake(rectCenter.x + outsideRectSize/2 + movedDistance*2 , rectCenter.y);
        pointD = CGPointMake(rectCenter.x - outsideRectSize/2, rectCenter.y);
    }else {
        pointB = CGPointMake(rectCenter.x + outsideRectSize/2, rectCenter.y);
        pointD = CGPointMake(rectCenter.x - outsideRectSize/2 - movedDistance*2, rectCenter.y);
    }
    
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + outsideRectSize/2 - movedDistance);
    
    //控制点
    CGPoint pointC1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint pointC2;
    CGPoint pointC3;
    
    if (self.movePoint == POINT_B) {
        pointC2 = CGPointMake(pointB.x, pointB.y - offset + movedDistance); // 增加了一个distance的距离
        pointC3 = CGPointMake(pointB.x, pointB.y + offset - movedDistance);
    }else {
        pointC2 = CGPointMake(pointB.x, pointB.y - offset);
        pointC3 = CGPointMake(pointB.x, pointB.y + offset);
    }
    
    CGPoint pointC4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint pointC5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint pointC6;
    CGPoint pointC7;
    if (self.movePoint == POINT_B) {
        pointC6 = CGPointMake(pointD.x, pointD.y + offset);
        pointC7 = CGPointMake(pointD.x, pointD.y - offset);
    }else {
        pointC6 = CGPointMake(pointD.x, pointD.y + offset - movedDistance);
        pointC7 = CGPointMake(pointD.x, pointD.y - offset + movedDistance);
    }
    
    CGPoint pointC8 = CGPointMake(pointA.x - offset, pointA.y);
    // 外面的虚线矩
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat dash[] = {5.0, 5.0};
    CGContextSetLineDash(ctx, 0.0, dash, 2); //1
    CGContextStrokePath(ctx); //给线条填充颜色
    
    // 圆
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:pointC1 controlPoint2:pointC2];
    [ovalPath addCurveToPoint:pointC controlPoint1:pointC3 controlPoint2:pointC4];
    [ovalPath addCurveToPoint:pointD controlPoint1:pointC5 controlPoint2:pointC6];
    [ovalPath addCurveToPoint:pointA controlPoint1:pointC7 controlPoint2:pointC8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0); //2  覆盖1的设置
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextFillPath(ctx);
    
    // 如下方法也可以绘制 因为用到UIkit的绘制方法 所以才需要UIGraphicsPushContext和UIGraphicsPopContext
//    UIGraphicsPushContext(ctx);
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
//    [[UIColor blueColor] setFill];
//    [p fill];
//    UIGraphicsPopContext();
     NSArray *points = @[[NSValue valueWithCGPoint:pointA],[NSValue valueWithCGPoint:pointB],[NSValue valueWithCGPoint:pointC],[NSValue valueWithCGPoint:pointD],[NSValue valueWithCGPoint:pointC1],[NSValue valueWithCGPoint:pointC2],[NSValue valueWithCGPoint:pointC3],[NSValue valueWithCGPoint:pointC4],[NSValue valueWithCGPoint:pointC5],[NSValue valueWithCGPoint:pointC6],[NSValue valueWithCGPoint:pointC7],[NSValue valueWithCGPoint:pointC8]];
    
    [self drawPoint:points withContext:ctx];
    
    UIBezierPath *helpPath = [UIBezierPath bezierPath];
    [helpPath moveToPoint:pointA];
    [helpPath addLineToPoint:pointC1];
    [helpPath addLineToPoint:pointC2];
    [helpPath addLineToPoint:pointB];
    [helpPath addLineToPoint:pointC3];
    [helpPath addLineToPoint:pointC4];
    [helpPath addLineToPoint:pointC];
    [helpPath addLineToPoint:pointC5];
    [helpPath addLineToPoint:pointC6];
    [helpPath addLineToPoint:pointD];
    [helpPath addLineToPoint:pointC7];
    [helpPath addLineToPoint:pointC8];
    [helpPath closePath];
    CGContextAddPath(ctx, helpPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGFloat dash1[] = {2.0, 2.0};
    CGContextSetLineDash(ctx, 0, dash1, 2);
    CGContextStrokePath(ctx); //给线条填充颜色
}

- (void)drawPoint:(NSArray *)points withContext:(CGContextRef)ctx {
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        CGContextFillRect(ctx, CGRectMake(point.x - 2,point.y - 2,4,4));
    }
}
//        A
//    .........
//    .       .
//  D .       . B
//    .       .
//    .........
//        C
//   上面的正方形内圈圆,AB BC CD DA是四段弧形 因为在拉动过程中形变 不能直接画圆 每段弧形有2个控制点如A-C1, C2-B
// 重写progress的set函数
- (void)setProgress:(CGFloat)progress {
    // 不能使用self.progress = progress 这样会导致循环调用setProgress函数 因为对属性赋值会调用对应的setter函数
    _progress = progress;
    // 向左移动那么D不动B动 否则相反
    if (progress <= 0.5) {
        self.movePoint = POINT_B;
    }else {
        self.movePoint = POINT_D;
    }
    
    CGFloat x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat y = self.position.x - outsideRectSize/2;
    self.outsideRect = CGRectMake( x, y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay]; // 刷新 调用drawInContext
}
@end
