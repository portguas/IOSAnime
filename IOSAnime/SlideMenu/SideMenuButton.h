//
//  SideMenuButton.h
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/13.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuButton : UIView

- (id)initWithTitle:(NSString *)title;

@property (nonatomic, strong) UIColor *btnColr;

@property (nonatomic, copy) void (^btnClickBlock)(void);

@end
