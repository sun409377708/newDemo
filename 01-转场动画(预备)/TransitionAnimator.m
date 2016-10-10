//
//  TransitionAnimator.m
//  01-转场动画(预备)
//
//  Created by teacher on 16/9/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "TransitionAnimator.h"

@interface TransitionAnimator() <UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)BOOL presenting;

@end

@implementation TransitionAnimator



#pragma mark
#pragma mark - 返回的对象, 就是动画代码的提供者
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.presenting = YES;
    return self;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    
    self.presenting = NO;
    return self;
}

#pragma mark
#pragma mark - 转场动画的时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

#pragma mark
#pragma mark - 转场动画主要方法

/**
 
 transitionContext : 在这个里面, 包含了转场动画需要的所有要素
 
 containerView : UITransitionView , 就相当于舞台
 
 // 获取控制器
 viewControllerForKey:
 UITransitionContextToViewControllerKey
 UITransitionContextFromViewControllerKey
 
 from : ViewController 
 to   : FirstViewController 被展示的控制器
 
 // 获取view
 viewForKey: 有可能为nil
 
 UITransitionContextFromViewKey
 UITransitionContextToViewKey
 
 
 
 // 动画是否完成 , 非常重要
 completeTransition:
    如果没有告知系统转场动画完成, 那么就会一直等待, 等待接收到动画结束的信号为止,
 等待期间无法交互
 */

- (CGFloat)isLeft {
    if (_isLeft == 0) {
        _isLeft = -1;
    }
    return _isLeft;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.presenting) {
        // 通过字符串常量Key从转场上下文种获得相应的对象
        UIView *containerView = [transitionContext containerView];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        // 要将toView添加到容器视图中
        [containerView addSubview:toView];
        
        // 自定义动画, 从中间开始进行y方向放大
        // 注意: 这边最好修改transform属性进行动画，否则视图中的子视图将不是你预期的动画效果
        // 1> 设置视图的初始状态，向左旋转 90 度
        
//        NSLog(@"%d", self.isLeft);
        
        CGFloat isLeft = [[NSUserDefaults standardUserDefaults] floatForKey:@"isLeft"];
        
        NSLog(@"%f", isLeft);
        
        toView.transform = CGAffineTransformMakeRotation(isLeft * M_PI_2);
        toView.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toView.transform = CGAffineTransformIdentity;
            toView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            //告诉系统动画已经完毕
            [transitionContext completeTransition:YES];
        }];
        
    }else {
        // 通过字符串常量Key从转场上下文种获得相应的对象
//        UIView *containerView = [transitionContext containerView];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

        // 先把原来的视图添加回去
//        [containerView insertSubview:toView atIndex:0];
        

        // 注意: 这边最好修改transform属性进行动画，否则视图中的子视图将不是你预期的动画效果
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.transform = CGAffineTransformMakeRotation(M_PI_2 * self.isLeft); //sy这边不能直接设置成0,否则看不出动画效果
        }
                         completion:^(BOOL finished){
                             BOOL success = ![transitionContext transitionWasCancelled];
                             
                             // 注意要把视图移除
                             [fromView removeFromSuperview];
                             
                             // 注意:这边一定要调用这句否则UIKit会一直等待动画完成  
                             [transitionContext completeTransition:success];
                         }];
        
    }
    
    
 
  
}



@end
