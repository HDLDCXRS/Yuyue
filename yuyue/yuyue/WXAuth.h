//
//  WXAuth.h
//  hongyantub2b
//
//  Created by Apple on 2018/8/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  WXAUTH [WXAuth sharedInstance]
typedef NS_ENUM(NSInteger,MyPayStaus){
    PaySuccess,
    PayFailure,
    PayCancel
};
typedef void (^MyPayCompleteBlock)(MyPayStaus payStatus);
@interface WXAuth : NSObject

//全局管理对象
+ (WXAuth *)sharedInstance;
//处理微信回调
- (BOOL)handleOpenURL:(NSURL *)url;
- (void)sendWXAuthReq;
+ (BOOL)handleAlipayURL:(NSURL *)url;

/**
 *  发起支付宝支付 ( signString为签名后的字符串
 */
+ (void)alipayWithParam:(NSString *)signString completeBlock:(MyPayCompleteBlock)completeBlock;

/**
 *  发起微信支付 ( param微信支付所需的参数
 */
+ (void)wxpayWithParam:(NSDictionary *)param completeBlock:(MyPayCompleteBlock)completeBlock;
@end
