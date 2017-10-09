//
//  ViewController.m
//  SpringAnimation
//
//  Created by He,Yulong on 2017/6/14.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"
#import "TestCusView.h"
#import "SecondViewController.h"

@interface ViewController (){
    CADisplayLink *displayLink;
}

@property (nonatomic, weak) IBOutlet UIView *pupurView;
@property (nonatomic, weak) IBOutlet UIView *greenView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
//    self.viewGreen.frame = CGRectMake(-257 , 0, 257, 736);
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 138, 167, 40)];
//    view.backgroundColor = [UIColor redColor];
//    [self.viewGreen addSubview:view];
//    NSLog(@"sd");
    TestCusView *view = [[TestCusView alloc] initWithTest];
    [self.view addSubview:view];
    [self.viewGreen addSubview:view];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.viewGreen.bounds
                                               byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.viewGreen.bounds;
    layer.path = path.CGPath;
    self.viewGreen.layer.mask = layer;
    
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:self.viewGreen.bounds
//                                                byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer =[CAShapeLayer layer];//[[CAShapeLayer alloc]init];
//    maskLayer.frame = self.viewGreen.bounds;
//    maskLayer.path = path1.CGPath;
//    self.viewGreen.layer.mask  = maskLayer;
//    
    
    NSLog(@"viewcontroller -- viewDidLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    CGRect rect = self.pupurView.frame;
    CGRect rect1 = self.greenView.frame;
    [UIView animateWithDuration:0.7f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
        self.pupurView.center = CGPointMake(self.view.frame.size.width /2, rect.origin.y + rect.size.height/2);
    } completion:^(BOOL finish){
        
    }];
    
    [UIView animateWithDuration:0.7f delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
        self.greenView.center = CGPointMake(self.view.frame.size.width /2, rect1.origin.y + rect1.size.height/2);
    } completion:^(BOOL finish){
    }];
    
}

- (void)display:(CADisplayLink *)dis {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewcontroller -- viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewcontroller -- viewDidAppear");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewcontroller -- viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, 15)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    NSLog(@"viewcontroller -- viewDidLayoutSubviews");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *fbvc = [board instantiateViewControllerWithIdentifier:@"Second"];

//    CATransition *a=[CATransition animation];
//    a.duration = 0.4f;
//    a.type = kCATransitionMoveIn;
//    a.subtype = kCATransitionFromTop;
//    a.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [self.view.window.layer addAnimation:a forKey:@"kTransitionAnimation"];
    [self presentViewController:fbvc animated:YES completion:nil];

}

- (BOOL)shouldAutorotate {
    return YES;
}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}
@end
