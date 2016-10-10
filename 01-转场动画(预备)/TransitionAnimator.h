//
//  TransitionAnimator.h
//  01-转场动画(预备)
//
//  Created by teacher on 16/9/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

/**
 提供转场的 动画代码
 */

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionAnimator : NSObject <UIViewControllerTransitioningDelegate>

@property(assign, nonatomic)CGFloat isLeft;

@end
