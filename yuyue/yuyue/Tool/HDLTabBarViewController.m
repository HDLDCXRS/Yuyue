//
//  HDLTabBarViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HDLTabBarViewController.h"
#import "HDLNavagationViewController.h"
#import "FirstPageViewController.h"
#import "FocusViewController.h"
#import "VideoViewController.h"
#import "MineViewController.h"
@interface HDLTabBarViewController ()
@end

@implementation HDLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTabViewController];
}

-(void)initWithTabViewController
{
    
   
    FirstPageViewController  * firstPageVC = [[FirstPageViewController alloc] init];
    HDLNavagationViewController  *firstNav = [self setTabbatItemWithRootVC:firstPageVC img:@"首页" selectImg:@"首页蓝色" setTitle:@"首页"];
   
   
 
    FocusViewController  * fouceVC = [[FocusViewController alloc] init];
    HDLNavagationViewController  *focusNav = [self setTabbatItemWithRootVC:fouceVC img:@"关注" selectImg:@"关注蓝色" setTitle:@"关注"];
    VideoViewController  * videoVC = [[VideoViewController alloc] init];
  
    HDLNavagationViewController  *videoNav = [self setTabbatItemWithRootVC:videoVC img:@"视频" selectImg:@"视频蓝色" setTitle:@"视频"];
   
    
    MineViewController  * mineVC = [[MineViewController alloc] init];
    HDLNavagationViewController  *mineNav = [self setTabbatItemWithRootVC:mineVC img:@"我的" selectImg:@"我的蓝色" setTitle:@"我的"];

   
    self.viewControllers = @[firstNav,videoNav,focusNav,mineNav];
}
-(HDLNavagationViewController *)setTabbatItemWithRootVC:(id)VC img:(NSString *)imgStr selectImg:(NSString*)selectImage setTitle:(NSString *)title
{
    HDLNavagationViewController *nag = [[HDLNavagationViewController alloc] initWithRootViewController:VC];
   
    [nag.tabBarItem setImage:[[UIImage imageNamed:imgStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nag.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nag.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    nag.tabBarItem.title = title;
    [nag.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:RGBA(26, 151, 224, 1) forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    [nag.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:RGBA(153, 153, 153, 1) forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    return nag;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    //隐藏最根的导航条
//    self.navigationController.navigationBar.hidden = YES;
//}
@end
