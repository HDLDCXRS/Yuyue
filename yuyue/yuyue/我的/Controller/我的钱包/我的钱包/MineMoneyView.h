//
//  MineMoneyView.h
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCommonMoneyView.h"
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineMoneyView : UIView
@property(nonatomic,strong) MineCommonMoneyView  *lastMoneyView;
@property(nonatomic,strong) MineCommonMoneyView  *getMoneyView;
@property(nonatomic,strong) LoginModel  *model;
-(void)setModel:(LoginModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
