//
//  SideMenuButton.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/13.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "SideMenuButton.h"

@interface SideMenuButton ()
@property (nonatomic, strong) NSString *btnTitle;
@end

@implementation SideMenuButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.btnTitle = title;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    switch (tapCount) {
        case 1:
            if (self.btnClickBlock != nil) {
                self.btnClickBlock();
            }
            break;
            
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect {
    // rect为这个butoton的矩形的大小 从外面定义这个button的frame传近来， 然后在这个里面绘制和布局文字 实现一个button
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 整个矩形填充
    CGContextAddRect(context, rect);
    [self.btnColr set];
    CGContextFillPath(context);
    
    // 圆角内部填充
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:rect.size.height/2];
    [self.btnColr setFill];
    [roundPath fill];
    [[UIColor whiteColor] setStroke];
    roundPath.lineWidth = 1;
    [roundPath stroke];
    
    // 字体
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = @{NSParagraphStyleAttributeName: style, NSFontAttributeName: [UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]};
    //根据属性计算出size 布置文字位置
    CGSize size = [self.btnTitle sizeWithAttributes:attr];
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - size.height)/2, rect.size.width, size.height);
    [self.btnTitle drawInRect:r withAttributes:attr];
}
@end
