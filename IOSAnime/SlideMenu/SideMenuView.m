//
//  SideMenuView.m
//  IOSAnime
//
//  Created by He,Yulong on 2017/6/13.
//  Copyright © 2017年 He,Yulong. All rights reserved.
//

#import "SideMenuView.h"
#import "SideMenuButton.h"

#define buttonSpace 30
#define menuBlankWidth 50

@interface SideMenuView()

@property (nonatomic,strong) CADisplayLink *displayLink;
@property  NSInteger animationCount; // 动画的数量

@end

@implementation SideMenuView {
    
    UIVisualEffectView *blurView;
    UIView *helperSideView;
    UIView *helperCenterView;
    UIWindow *keyWindow;
    BOOL triggered;
    CGFloat diff;
    UIColor *_menuColor;
    CGFloat menuButtonHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithTitles:(NSArray *)title {
    return [self initWithTitles:title withButtonHeight:40 withMenuColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1] withBackBlurStyle:UIBlurEffectStyleDark];
}

- (id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)color withBackBlurStyle:(UIBlurEffectStyle)style {
    
    self = [super init];
    if (self) {
        keyWindow = [[[UIApplication sharedApplication] delegate] window];
        blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0.0f;
        // 下面是2个帮助view
        helperSideView = [[UIView alloc] initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helperSideView.backgroundColor = [UIColor redColor];
        helperSideView.hidden = YES;
        [keyWindow addSubview:helperSideView];
        
        helperCenterView = [[UIView alloc] initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.frame)/2 - 20, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        helperCenterView.hidden = YES;
        [keyWindow addSubview:helperCenterView];
        
        self.frame = CGRectMake(-keyWindow.frame.size.width/2 - menuBlankWidth, 0, keyWindow.frame.size.width/2 + menuBlankWidth, keyWindow.frame.size.height);
        self.backgroundColor = [UIColor redColor];
        [keyWindow insertSubview:self belowSubview:helperSideView];
        
        _menuColor = color;
        menuButtonHeight = height;
        [self addButtons:titles];
    }
    
    return self;
}

- (void)addButtons:(NSArray *)titles{
    if (titles.count %2 == 0) {
        NSInteger index_down = titles.count/2;
        NSInteger index_up = -1;
        for(NSInteger i = 0; i < titles.count; i++){
            // 下面的操作都是为了保证menuitem是在整个布局中间
            NSString *title = titles[i];
            SideMenuButton *btn = [[SideMenuButton alloc] initWithTitle:title];
            if (i >= titles.count / 2) {
                index_up++;
                btn.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height / 2 + buttonSpace/2 + menuButtonHeight/2 + index_up * menuButtonHeight + index_up*buttonSpace);
            }else {
                index_down--;
                btn.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - buttonSpace/2 - menuButtonHeight/2 - index_down * menuButtonHeight - index_down*buttonSpace);
            }
            
            btn.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 2*20, menuButtonHeight);
            btn.btnColr = _menuColor;
            [self addSubview:btn];
            __weak typeof(self) WeakSelf = self;
            
            btn.btnClickBlock = ^(){
                [WeakSelf tapToUntrigger];
                WeakSelf.menuClickBlock(i, title, titles.count);
            };
        }
    }else {
        NSInteger index = (titles.count - 1) /2 +1;
        for(NSInteger i = 0; i < titles.count; i++) {
            index --;
            NSString *title = titles[i];
            SideMenuButton *btn = [[SideMenuButton alloc] initWithTitle:title];
            btn.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - index*menuButtonHeight - index*buttonSpace);
            
            btn.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 2*20, menuButtonHeight);
            btn.btnColr = _menuColor;
            [self addSubview:btn];
            __weak typeof(self) WeakSelf = self;
            
            btn.btnClickBlock = ^(){
                [WeakSelf tapToUntrigger];
                WeakSelf.menuClickBlock(i, title, titles.count);
            };
        }
    }
}

- (void)trigger {
    if (!triggered) {
        [keyWindow insertSubview:blurView belowSubview:self];
        [UIView animateWithDuration:0.3 animations:^(){
            self.frame = self.bounds;
        }];
        // 初始化CADisplayLink
        [self beforeAnimation];
        
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
            helperSideView.center = CGPointMake(keyWindow.center.x, helperSideView.frame.size.height/2);
        } completion:^(BOOL finish){
            [self finishAnimation];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            blurView.alpha = 0.5f;
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
            helperCenterView.center = keyWindow.center;
        } completion:^(BOOL finish){
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToUntrigger)];
            [blurView addGestureRecognizer:tapGes];
            [self finishAnimation];
        }];
        
        [self animateButtons];
        triggered = YES;
    }else{
        [self tapToUntrigger];
    }
}

//动画之前调用
-(void)beforeAnimation{
    
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

- (void)finishAnimation {
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)animateButtons {
    for (NSInteger i = 0 ; i < self.subviews.count; i++) {
        UIView *menuBtn = self.subviews[i];
        // 先把所以的menu菜单移出去
        menuBtn.transform = CGAffineTransformMakeTranslation(-90, 0);
        // 然后动画移动回来
        [UIView animateWithDuration:0.7f delay:i*(0.3/self.subviews.count) usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
            menuBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finish){
            
        }];
    }
}

- (void)tapToUntrigger {
    // 关闭menu
    [UIView animateWithDuration:0.3 animations:^(){
        self.frame = CGRectMake(-keyWindow.frame.size.width/2-menuBlankWidth, 0, keyWindow.frame.size.width/2 + menuBlankWidth, keyWindow.frame.size.height);
    }];
    
    [self beforeAnimation];
    
    // 2个helpe view还原
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helperSideView.center = CGPointMake(-helperSideView.frame.size.height/2, helperSideView.frame.size.height/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        blurView.alpha = 0.0f;
    }];
    
    [self beforeAnimation];
    
    [UIView animateWithDuration:0.7f delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^(){
        helperCenterView.center = CGPointMake(-helperCenterView.frame.size.width/2, keyWindow.frame.size.height/2);
    } completion:^(BOOL finish){
        [self finishAnimation];
    }];
    triggered = NO;
    
}

- (void)displayLinkAction:(CADisplayLink *)dis {
    CALayer *sideHelperPresentationLayer   =  (CALayer *)[helperSideView.layer presentationLayer];
    CALayer *centerHelperPresentationLayer =  (CALayer *)[helperCenterView.layer presentationLayer];
    
    CGRect centerRect = [[centerHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    
    // diff是引起外部重绘的因素
    diff = sideRect.origin.x - centerRect.origin.x;
    NSLog(@"diff--%f", diff);
    // diff改变 就开始重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(self.frame.size.width - menuBlankWidth, 0)];
//    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - menuBlankWidth, self.frame.origin.y) controlPoint:CGPointMake(keyWindow.frame.size.width/2+diff, self.frame.size.height/2)];
//    [path addLineToPoint:CGPointMake(0, self.frame.origin.y)];
//    
//    [path closePath];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-menuBlankWidth, 0)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width-menuBlankWidth, self.frame.size.height) controlPoint:CGPointMake(keyWindow.frame.size.width/2+diff, keyWindow.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
    
//    [path setLineWidth:1.0f];
//    [_menuColor set];
//    
//    [path fill];
}
@end
