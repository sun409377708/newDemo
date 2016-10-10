//
//  ViewController.m
//  01-转场动画(预备)
//
//  Created by teacher on 16/9/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改控制器view的锚点
    self.view.layer.anchorPoint = CGPointMake(0.5, 1.5);
    
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (IBAction)clickButton:(id)sender {
    
    
    FirstViewController *first = [[FirstViewController alloc] init];
    
    
    // 通过代码方式创建的 viewController 中view的颜色, 默认是nil
    [self presentViewController:first animated:YES completion:nil];
    
    
    
}

@end
