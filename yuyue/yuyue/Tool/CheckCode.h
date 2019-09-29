//
//  CheckCode.h
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CheckCode : NSObject
//校验身份证
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString postUIViewController:(UIViewController *)vc;
//手机号验证
+ (BOOL) validateMobile:(NSString *)mobileNum postUIViewController:(UIViewController *)vc;
//密码验证
+ (BOOL) validatePassword:(NSString *)passWord;
@end

NS_ASSUME_NONNULL_END
