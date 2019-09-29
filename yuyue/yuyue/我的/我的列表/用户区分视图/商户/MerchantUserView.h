//
//  MerchantUserView.h
//  yuyue
//
//  Created by edz on 2019/9/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonCommonView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CommonBtnBlock)(UIButton *btn);
@interface MerchantUserView : UIView
@property(nonatomic,strong) UIImageView  *bgcView;
@property(nonatomic,strong) UIButtonCommonView  *scanBtn;
@property(nonatomic,strong) UIButtonCommonView  *mineMoneyBtn;
@property(nonatomic,strong) UIButtonCommonView  *minePublish;
@property(nonatomic,strong) UIButtonCommonView  *merchantBtn;
@property(nonatomic,copy) CommonBtnBlock  click;
@end

NS_ASSUME_NONNULL_END
