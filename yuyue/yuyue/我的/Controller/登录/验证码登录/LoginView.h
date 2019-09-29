//
//  LoginView.h
//  yuYue
//
//  Created by edz on 2019/8/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyBlock)(NSInteger index);
@interface LoginView : UIView
//验证码
@property(nonatomic,strong) UIButton  * codeBtn;
@property(nonatomic,strong) UIButton  *loginBtn;
@property(nonatomic,strong) UIImageView  * photoImg;
@property(nonatomic,strong) UIImageView  *photoCodeImg;
@property(nonatomic,strong) UITextField  * photoTextField;
@property(nonatomic,strong) UITextField  * photoCodeTextField;
@property(nonatomic,strong) UIButton  *  getImgBtn;
@property(nonatomic,strong) UIButton  * loginingBtn;

@property(nonatomic,copy) MyBlock   clickBlock;
/*
 * 定时器
 */
@property(strong,nonatomic) NSTimer *timer;

/*
 * 定时多少秒
 */
@property(assign,nonatomic) NSInteger count;
- (void)timeFailBeginFrom:(NSInteger)timeCount;
@end

NS_ASSUME_NONNULL_END
