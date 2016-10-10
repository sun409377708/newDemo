//
//  FirstViewController.m
//  01-转场动画(预备)
//
//  Created by teacher on 16/9/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "FirstViewController.h"
#import "TransitionAnimator.h"

@interface FirstViewController ()

{
    TransitionAnimator *_animator;
}

@end

@implementation FirstViewController


#pragma mark
#pragma mark - 控制器指定的实例化方法

// 如果调用了 alloc init 实例化控制器, 内部会默认调用下面这个方法, 参数都是 nil
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        // 1. 设置转场样式为自定义
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        // 2. 设置动画代理
        
        // 实例化动画对象
        
#warning 需要有强指针指向动画对象
        _animator = [[TransitionAnimator alloc] init];
        
        self.transitioningDelegate = _animator;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 设置 转场样式 , 打开了自定义转场动画, 如果没有动画代码的实现, 默认使用系统样式
//    self.modalPresentationStyle = UIModalPresentationCustom;
    
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
    
    // anchorPoint : 定位点, 确定position 在自身上的位置 左上角: 0,0, 右下角: 1, 1
    // position : 中心点/定位点, 决定自身在父view上的位置
    // anchorPoint 和 position 虽然坐标系不一样/数值不一样, 但是, 他们是重合的
    
//     NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    
    /**
     frame
     * rectangle, a function of the `position', `bounds', `anchorPoint',
     * and `transform'
     
     frame ; 是 由 上面这几个属性, 共同计算而来的
     修改anchorPoint 和  Position 都会影响frame
     
     When setting the frame the `position'
     * and `bounds.size' are changed to match the given frame
     
     如果设置了frame, position 和 bounds.size 会自适应的改变
     如果设置了frame : 
     */
    
    self.view.layer.anchorPoint = CGPointMake(0.5, 1.5);
    
    // 修改view的frame
    self.view.frame = [UIScreen mainScreen].bounds;
    
//    NSLog(@"%@", NSStringFromCGPoint(self.view.layer.position));
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


#pragma mark
#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    // 1. 获取移动距离
    CGPoint movePoint = [pan translationInView:pan.view];
    
    // 2. 计算比例
    CGFloat ratio = movePoint.x / self.view.frame.size.width;
    
    // 3. 计算旋转的角度
    CGFloat angle = ratio * M_PI_2;
    
    // 4. 让view旋转
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            case UIGestureRecognizerStateChanged:
        {
            // 进行旋转
            self.view.transform = CGAffineTransformMakeRotation(angle);
        }
            break;
            
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateFailed:
            case UIGestureRecognizerStateCancelled:
            
        {
            if (ABS(angle) > 0.4) {
                _animator.isLeft = (angle > 0) ? 1 : -1;
//                NSLog(@"%d", _animator.isLeft);
                
                [[NSUserDefaults standardUserDefaults] setFloat:_animator.isLeft forKey:@"isLeft"];
                
                
                
                // 消失
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                
                // 恢复
                [UIView animateWithDuration:0.5 animations:^{
                   
                    self.view.transform = CGAffineTransformIdentity;
                }];
            }
            
        }
            break;
            
        default:
            break;
    }
}


@end
