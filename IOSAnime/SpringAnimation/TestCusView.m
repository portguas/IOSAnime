//
//  TestCusView.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/15.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "TestCusView.h"

@implementation TestCusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 自定义的构造函数必需init开头 返回id
- (id)initWithTest{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(100, 10, 100, 100);
    }
    
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"view -- layoutSubviews");
}

@end
