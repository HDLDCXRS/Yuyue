//
//  MyWithDrawalView.h
//  yuyue
//
//  Created by edz on 2019/9/25.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyClick)(UIButton *btn);
@interface MyWithDrawalView : UIView
@property(nonatomic,strong) UILabel  *moneyLabel;  //可提现金额
@property(nonatomic,strong) UILabel  *jinELabel; //提现金额
@property(nonatomic,strong) UILabel  *applyLabel; //申请提现金额
@property(nonatomic,strong) UITextField  *appTextField; //请输入金额
@property(nonatomic,strong) UILabel  *tixianLabel; //提现至
@property(nonatomic,strong) UIImageView  *wxImage; //
@property(nonatomic,strong) UILabel  *weixinLabel;
@property(nonatomic,strong) UILabel  *titileLabel;
@property(nonatomic,strong) UIButton  *commitBtn;

@property(nonatomic,copy)   MyClick click;
@end

NS_ASSUME_NONNULL_END
