//
//  ViewController.m
//  ImplictAnime
//
//  Created by He,Yulong on 2017/5/26.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIView *layerView;
@property (nonatomic, strong)  CALayer *colorLayer;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.layerView.backgroundColor = [UIColor yellowColor];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.layerView.bounds;
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    UITapGestureRecognizer * reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.button addGestureRecognizer:reg];
}


- (void)tap:(UITapGestureRecognizer *)reg  {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    // 颜色平滑变化
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    // Core Animation通常对CALayer的所有属性（可动画的属性）做动画，但是UIView把它关联的图层的这个特性关闭了
    // 如下代码发现颜色是瞬间变换的 不是平滑的
//    self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
