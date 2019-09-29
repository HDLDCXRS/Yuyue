//
//  RegistLoginView.h
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReginstLoginstCommonView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^MyBlock)(NSInteger index);
@interface RegistLoginView : UIView
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_one;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_two;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_three;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_four;
@property(nonatomic,copy) MyBlock  click;
@property(nonatomic,strong) UIButton  *footerBtn;
//
@property(nonatomic,strong) UIButton  *iconBtn;
@property(nonatomic,strong) UILabel  *headLabel;
@property(nonatomic,strong) UILabel  *userLabel;


@property(nonatomic,strong) UILabel  *companyLabel;


@end

NS_ASSUME_NONNULL_END
