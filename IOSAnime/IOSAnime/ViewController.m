//
//  ViewController.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/5/23.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *sliderCtl;

@property (weak, nonatomic) IBOutlet UILabel *curProgress;
@property (strong, nonatomic) CircleView *cv;


@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.cv = [[CircleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 320/2, self.view.frame.size.height/2 - 320/2, 320, 320)];
//    self.cv.backgroundColor = [UIColor purpleColor];
//    
//    [self.view addSubview:self.cv];
    
    // progress这个值在实际应用中由viewcontroller传入，即作为输入 控制源
//    self.cv.circleLayer.progress = 0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.testView.bounds cornerRadius:40];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = self.testView.bounds;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
//    layer.mask
    [self.testView.layer addSublayer:layer];
    
//    self.testView.layer.backgroundColor = [UIColor blueColor].CGColor;
    self.testView.backgroundColor = [UIColor blueColor];
    
//    self.testView.layer.cornerRadius = 40;
//    self.testView.layer.borderColor = [UIColor redColor].CGColor;
//    self.testView.layer.borderWidth = 1;
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.testView addGestureRecognizer:gesture];
}
- (IBAction)tap:(id)sender {
}
- (IBAction)tap:(id)sender {
}
- (IBAction)startProgress:(UIButton *)sender {
}


// ad
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)progressChanged:(UISlider *)sender {
    
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tapped");
}

@end
