//
//  CircleView.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/5/23.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame]; // 因为我们修改了Layer的默认Class，所以在这个函数里会调用到circleLayer的init函数
    if (self) {
        self.circleLayer = [CircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [[UIScreen mainScreen] scale];
        [self.layer addSublayer:self.circleLayer];
    }
    
    return self;
}
@end
