//
//  ViewController.m
//  SlideMenu
//
//  Created by He,Yulong on 2017/6/13.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "ViewController.h"
#import "SideMenuView.h"

@interface ViewController (){
    SideMenuView *menu;
}

@end

@implementation ViewController

// 此时UIWindow * window = [[UIApplication sharedApplication] keyWindow]; windos不为nil
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    menu = [[SideMenuView alloc] initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置", @"测试"]];
    menu.menuClickBlock = ^(NSInteger index, NSString *title, NSInteger titleCounts){
        
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [window makeKeyAndVisible];
    // Do any additional setup after loading the view, typically from a nib.
    // 如果rootview不是navigationcontroller 获取tabviewcontroller那么下面的win是为nil的
    // 即使使用[[[UIApplication sharedApplication] delegate]window]获取不为nil，但是我们的
    // 抽屉创建代码不能添加在这里, 因为这个时候我们的viewcontroller还没添加到window上面,会导致后续抽屉布局
    // 被viewcontroller完全挡住，因此如果我们是一个viewcontroll为rootviewcontroller的时候我们把抽屉的创建
    // 放到viewDidAppear上面
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
//    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"首页";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tragger:(id)sender {

    [menu trigger];
}

- (IBAction)ceshi:(id)sender {

}

@end
