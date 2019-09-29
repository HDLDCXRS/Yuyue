//
//  CodeView.h
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyBlock)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN
@interface CodeView : UIView
@property(nonatomic,strong) UIButton  * codeLoginBtn;
@property(nonatomic,strong) UIButton  * passwordBtn;
@property(nonatomic,strong) UIImageView  * photoImg;
@property(nonatomic,strong) UITextField  * photoTextField;  //手机号
@property(nonatomic,strong) UIImageView  * lockImage;
@property(nonatomic,strong) UITextField * passwordTextField;
@property(nonatomic,strong) UIButton  * forgetPasswordBtn;
@property(nonatomic,strong) UIButton  * loginBtn;
@property(nonatomic,copy) MyBlock   clickBlock;
@end

NS_ASSUME_NONNULL_END
