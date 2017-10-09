//
//  PaoPaoView.h
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/15.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaoPaoView : UIView

- (id)initWithPoint:(CGPoint)point withSuperView:(UIView*)view;

- (void)setUp;

@property (nonatomic,strong)UIView *frontView;

@end
