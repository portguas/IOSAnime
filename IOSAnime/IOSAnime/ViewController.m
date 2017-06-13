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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cv = [[CircleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 320/2, self.view.frame.size.height/2 - 320/2, 320, 320)];
    self.cv.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.cv];
    
    // progress这个值在实际应用中由viewcontroller传入，即作为输入 控制源
    self.cv.circleLayer.progress = self.sliderCtl.value;

}

- (IBAction)startProgress:(UIButton *)sender {
}


// ad
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)progressChanged:(UISlider *)sender {
    self.curProgress.text = [NSString stringWithFormat:@"Current:  %f",sender.value];
    self.cv.circleLayer.progress = sender.value;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tapped");
}

@end
