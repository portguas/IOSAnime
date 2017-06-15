//
//  ViewController.m
//  SpringAnimation
//
//  Created by He,Yulong on 2017/6/14.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"

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


@end
