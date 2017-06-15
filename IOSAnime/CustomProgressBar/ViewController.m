//
//  ViewController.m
//  CustomProgressBar
//
//  Created by He,Yulong on 2017/5/26.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) UIView *viewbg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.viewbg = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 250, 20)];
    self.viewbg.layer.cornerRadius = 8;
    self.viewbg.backgroundColor = [UIColor whiteColor];
    self.viewbg.layer.borderColor = [UIColor blueColor].CGColor;
    self.viewbg.layer.borderWidth = 1;
    
    [self.view addSubview:self.viewbg];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    NSArray *colorArr = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,
                         (id)[UIColor blueColor].CGColor,
                         (id)[UIColor yellowColor].CGColor,
                         (id)[UIColor greenColor].CGColor,nil];
    
    NSArray *locationArr = @[@(0.3), @(0.5),@(0.7),@(1)];
    
    gradientLayer.colors = colorArr;
    gradientLayer.locations = locationArr;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = self.viewbg.bounds;
    gradientLayer.masksToBounds = YES;
    gradientLayer.cornerRadius = 8;

    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(0, 0, 0, 20); // 高度设置为和背景高度一样
    self.maskLayer.borderWidth = 1;
    self.maskLayer.backgroundColor = [UIColor yellowColor].CGColor;  // 必需设置颜色使masklayer不透明 如果是透明那么就会遮蔽下面的layer
//    self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    gradientLayer.mask = self.maskLayer;
    
   [self.viewbg.layer addSublayer:gradientLayer];

    
}
- (IBAction)tr:(UIButton *)sender {
}
- (IBAction)ab:(id)sender {
}
- (IBAction)changeColor:(id)sender {
}

- (IBAction)a:(id)sender {
    
//    [UIView animateWithDuration:10 animations:^{
//        self.maskLayer.frame = CGRectMake(0, 0, 250, 20);
//    }];
//
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];  // 不能关闭隐式动画 因为关闭后就会瞬间完成
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setAnimationDuration:3];   // 如果设置为默认的0.25秒会发现很快完成动画,但是也不是瞬间完成,会比瞬间要平滑点
    self.maskLayer.frame = self.viewbg.bounds;  // 通过直接改变图层属性来实现动画 隐式动画
                                                // Core Animation通常对CALayer的所有属性（可动画的属性）做动画包括frame, 但是显示动画无法对frame做动画 记住！
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
