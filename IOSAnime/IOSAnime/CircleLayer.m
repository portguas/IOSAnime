//
//  CircleLayer.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/5/23.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "CircleLayer.h"

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
    
}
//        A
//    .........
//    .       .
//  D .       . B
//    .       .
//    .........
//        C
//   上面的正方形内圈圆,AB BC CD DA是四段弧形 因为在拉动过程中形变 不能直接画圆 每段弧形有2个控制点
// 重写progress的set函数
- (void)setProgress:(CGFloat)progress {
    self.progress = progress;
    // 向左移动那么D不动B动 否则相反
    if (progress <= 0.5) {
        self.movePoint = POINT_B;
    }else {
        self.movePoint = POINT_D;
    }
    
    CGFloat x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat y = self.position.x - outsideRectSize/2;
    self.outsideRect = CGRectMake( x, y, outsideRectSize, outsideRectSize);
}
@end
