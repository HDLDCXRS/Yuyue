//
//  CommonDefine.h
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h
//屏幕的宽度和高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//获取导航栏状态栏的高度

#define NavRect self.navigationController.navigationBar.frame
#define StatusRect [[UIApplication sharedApplication] statusBarFrame].size.height
#define getRectNavAndStatusHight self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define Status_Height ((is_iPhoneXs == YES || is_iPhoneXr == YES || is_iPhoneXsMax == YES) ? 44.0 : 20.0)
//导航栏高度
#define NavBar_Height ((is_iPhoneXs == YES || is_iPhoneXr == YES || is_iPhoneXsMax == YES) ? 88.0 : 64.0)
//tabBar高度
#define TabBar_Height ((is_iPhoneXs == YES || is_iPhoneXr == YES || is_iPhoneXsMax == YES) ? 83.0 : 49.0)

//使用imageWithContentOfFile找PNG类型的图片
#define UIImageFilePNG(fileName) [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", fileName, (is_iPhone5 || is_iPhone6 || is_iPhoneXr) ? @"@2x" : @"@3x"] ofType:@"png"]]
//判断iPhone5系列       5,5s
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhone6系列       6,7,8,6s
#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+系列      6plus,7plus,8plus,6splus
#define is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr        Xr
#define is_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneX系列       X,Xs
#define is_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max     Xs Max
#define is_iPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#import "CHYCategory.h"
#define  WEBURLA  [NSURL URLWithString:@"http://101.37.252.177:8082/yuyue-app/"]
#define TOKEN [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]
#define getUerDefualt [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"token"]
#import "NSString+Size.h"

#endif /* CommonDefine_h */
