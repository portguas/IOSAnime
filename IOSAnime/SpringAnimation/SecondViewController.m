//
//  SecondViewController.m
//  IOSAnime
//
//  Created by Baidu on 2017/7/3.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    CATransition *a=[CATransition animation];
//    a.duration = 4.4f;
//    a.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    a.type = kCATransitionReveal;
////    UIDeviceOrientation ori =  [[UIDevice currentDevice] orientation];
////    if (ori == UIDeviceOrientationLandscapeLeft) {
////        a.subtype = kCATransitionFromRight;
////    }else if(ori == UIDeviceOrientationLandscapeRight){
////        a.subtype = kCATransitionFromLeft;
////    }else{
////        a.subtype = kCATransitionFromBottom;
////    }
//    a.subtype = kCATransitionFromBottom;
//    [self.view.window.layer addAnimation:a forKey:@"dismiss"];
//    CGRect rect = self.view.window.layer.frame;
//    NSLog(@"rect %@", NSStringFromCGRect(rect));
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)shouldAutorotate  {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
