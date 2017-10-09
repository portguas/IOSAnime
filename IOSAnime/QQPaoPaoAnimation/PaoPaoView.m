//
//  PaoPaoView.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/15.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "PaoPaoView.h"

static const CGFloat paopaoWidth = 30;

@implementation PaoPaoView{
    
    UIView *backView; // 小圆
    UIView *superView;
    
    CGPoint originPoint;
    CGFloat r1;  // 小圆半径
    CGFloat r2;  // 大圆半径
    
    
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint pointO;
    CGPoint pointP;
    
    CAShapeLayer *shapeLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithPoint:(CGPoint)point withSuperView:(UIView *)view{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 200, 200)];
    if (self) {
        originPoint = point;
        superView = view;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    shapeLayer = [CAShapeLayer layer];
    
    r1 = paopaoWidth / 4;
    r2 = paopaoWidth / 2;
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(originPoint.x + paopaoWidth/2, originPoint.y + paopaoWidth/2, r1 * 2, r1*2)];
    backView.layer.cornerRadius = r1;
    backView.backgroundColor = [UIColor greenColor];
    backView.hidden = YES;
    [self addSubview:backView];
    
    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(originPoint.x, originPoint.y, paopaoWidth , paopaoWidth)];
    self.frontView.layer.cornerRadius = paopaoWidth/2;
    self.frontView.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.frontView];
    
    // 添加气泡晃动的动画
    [self addAniamtionLikeGameCenterBubble];
    
    
    UIPanGestureRecognizer *recog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    
    [self.frontView addGestureRecognizer:recog];
    
}

- (void)addAniamtionLikeGameCenterBubble {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced; // 此模式下timeFunction和keytime无效
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
//    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    
    // 可以使圆在一个离圆心距离3的位置的圆转动
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(self.frontView.frame, self.frontView.bounds.size.width/2  - 3, self.frontView.bounds.size.width/2  - 3);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [self.frontView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 1;
    scaleX.values = @[@1.0,@1.1, @1.0];
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    scaleX.repeatCount = INFINITY;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;  // 与scaleX错开点时间
    scaleY.values = @[@1.0,@1.1, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleY forKey:@"scaleXYAnimation"];
    
    // 注意这2个时间 设置的是CAKeyframeAnimation的一半 才会和他的效果一样！
//    CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
//    anime.duration = 0.5;
//    anime.fromValue = @1;
//    anime.toValue=@1.1;
//    anime.repeatCount = INFINITY;
//    anime.autoreverses = YES;
//    anime.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.frontView.layer addAnimation:anime forKey:@"scaleXYAnimation"];
//    
//    CABasicAnimation *anime1 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
//    anime1.duration = 0.75;
//    anime1.fromValue = @1;
//    anime1.toValue=@1.1;
//    anime1.repeatCount = INFINITY;
//    anime1.autoreverses = YES;
//    anime1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.frontView.layer addAnimation:anime1 forKey:@"scaleYAnimation"];
    
}

-(void)removeAniamtionLikeGameCenterBubble {
    [self.frontView.layer removeAllAnimations];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recog {
    
    CGPoint dragPoint = [recog translationInView:superView];
    if (recog.state == UIGestureRecognizerStateBegan) {
        //
        backView.hidden = NO;
        // 先停止所有动画
        [self removeAniamtionLikeGameCenterBubble];
    }else if(recog.state == UIGestureRecognizerStateChanged) {
        self.frontView.center = dragPoint;
        // 拉到一定程序的时候消失
        if (r1 < 6) {
            backView.hidden = YES;
            [shapeLayer removeFromSuperlayer];
        }
        [self drawRect];
    }else if(recog.state == UIGestureRecognizerStateEnded
             || recog.state == UIGestureRecognizerStateFailed
             || recog.state == UIGestureRecognizerStateCancelled) {
        
    }
}

- (void)drawRect{
    
}

@end
