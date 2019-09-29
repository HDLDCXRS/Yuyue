//
//  HDLNavagationViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HDLNavagationViewController.h"

@interface HDLNavagationViewController ()

@end

@implementation HDLNavagationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条上标题的颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(51, 51, 51, 1),NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:18]}];
   // self.view.backgroundColor = [UIColor whiteColor];
 
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    if (self.viewControllers.count > 1)
    {
        // 隐藏底部选项卡,显示顶部导航栏
        viewController.navigationController.navigationBarHidden = NO;
        viewController.tabBarController.tabBar.hidden = YES;
     // 添加导航栏左边返回按钮
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,20, 30, 30)];
        [leftBtn setImage:[UIImage imageNamed:@"左箭头"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"箭头背景"]forState:UIControlStateHighlighted];
        
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
    }
}

- (void)leftBtnClick
{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [super popViewControllerAnimated:animated];
    
    if (self.viewControllers.count == 1)
    {
        self.tabBarController.tabBar.hidden = NO;
    }
   
    return self;
}


@end
