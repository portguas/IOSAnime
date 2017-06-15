//
//  SideMenuView.h
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/13.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuClickBlock)(NSInteger index, NSString *title, NSInteger titleCounts);

@interface SideMenuView : UIView

- (id)initWithTitles:(NSArray *)titles;

- (id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)color withBackBlurStyle:(UIBlurEffectStyle)style;

- (void)trigger;

@property(nonatomic, copy) MenuClickBlock menuClickBlock;

@end
