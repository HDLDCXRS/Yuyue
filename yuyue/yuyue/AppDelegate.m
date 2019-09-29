//
//  AppDelegate.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "HDLTabBarViewController.h"
#import "HDLNavagationViewController.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "WXApi.h"
#import "WXAuth.h"

#define WXAppId            @"wx82e0374be0e044a4"//填上应用的AppID
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif  //写在实现的上面
static NSString *appKey = @"";// 极光给你返回的apKeyc9b42236019679709d0d0ebe
static NSString *channel = nil;//APP销售路径( 自己的理解) 一般都填APP Store
//#ifdef DEBUG
//// 开发 极光FALSE为开发环境
//static BOOL const  isProduction = FALSE;
//#else
// 生产 极光TRUE为生产环境
static BOOL const  isProduction = TRUE;
@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HDLTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    [self registJiGuang:launchOptions];
    [WXApi registerApp:WXAppId ];
  
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WXAUTH handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    return [WXAUTH handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WXAUTH handleOpenURL:url];
}
-(void)registJiGuang:(NSDictionary *)launchOptions
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        // categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else
    {
        // categories nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (resCode == 0) {
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else {
            NSLog(@"registrationID获取失败：%d",resCode);
        }
    }];
    NSDictionary *resultDic = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (resultDic) {//推送进入APP
        
        NSLog(@"app未启动，推送进入，直接显示预警界面");
        
        //相应界面跳转方法
        
    }else{//正常进入APP
        
    }
}
- (void)applicationDidEnterBackground:(UIApplication *)application {

    [self cleanBadge];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self cleanBadge];
    [application cancelAllLocalNotifications];
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    NSLog(@"%@",[NSString stringWithFormat:@"Device Token:%@",deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//程序无论在前后台都会执行这个方法
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    
    
    //[rootViewController addNotificationCount];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //处于前台
        NSLog(@"前台");
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        //处于后台
        NSLog(@"后台");
        [self goToMessageViewControllerWithDic:userInfo];
    }
    
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            NSLog(@"程序在前台");
            
            
        }
        
        else{
            //跳转到指定页面
            [self goToMessageViewControllerWithDic:userInfo];
            //这里也可以发送个通知,跳转到指定页面
            // [self readNotificationVcWithUserInfo:userInfo];
        }
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
//只有点击消息推送之后才会进来,获取推送内容,跳转页面,都在这个回调里边
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        //[rootViewController addNotificationCount];
        //跳到指定页面
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            NSLog(@"程序在前台");
            [self goToMessageViewControllerWithDic:userInfo];
        }
        
        else{
            //跳转到指定页面
            [self goToMessageViewControllerWithDic:userInfo];
            
        }
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 清空通知标志
- (void)cleanBadge{
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication]cancelAllLocalNotifications];//取消任何通知标志
    
}
- (void)goToMessageViewControllerWithDic:(NSDictionary *)userInfo {
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push"forKey:@"push"];
    [pushJudge synchronize];
    // 这个是我要跳到的聊天页面 (你的目标页面)
//    JYJ_ChatViewController *chatVC = [[JYJ_ChatViewController alloc]init];
//    chatVC.tag = 4;
//    chatVC.notify_id = [[NSString stringWithFormat:@"%@",userInfo[@"notify_id"]] intValue];
//    BaseNavigationController * Nav = [[BaseNavigationController alloc]initWithRootViewController:chatVC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
//    [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
    
}
@end
