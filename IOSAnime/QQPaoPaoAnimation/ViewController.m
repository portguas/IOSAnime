//
//  ViewController.m
//  QQPaoPaoAnimation
//
//  Created by He,Yulong on 2017/6/15.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"
#import "PaoPaoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PaoPaoView *view = [[PaoPaoView alloc] initWithPoint:CGPointMake(100, 100) withSuperView:self.view];
    [self.view addSubview: view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
