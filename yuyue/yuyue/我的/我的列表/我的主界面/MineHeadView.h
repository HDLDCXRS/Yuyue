//
//  MineHeadView.h
//  yuYue
//
//  Created by edz on 2019/8/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
#import "MineArtView.h"
#import "CommonUserView.h"
#import "ArtUserView.h"
#import "MerchantUserView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(NSInteger index);
@interface MineHeadView : UIView
@property(nonatomic,strong) UIImageView  * headView;
@property(nonatomic,strong) UIImageView  * icomImg;
@property(nonatomic,strong) UIButton  * loginBtn;
@property(nonatomic,strong) UIButton  * registBtn;
@property(nonatomic,strong) UIImageView  * bgcView;
@property(nonatomic,strong) UIButton  * scanBtn;
@property(nonatomic,strong) UIButton  * mineMoneyBtn;
@property(nonatomic,strong) UIButton  * SetUpBtn;
//我的广告
//我的发布
@property(nonatomic,strong) UILabel  * publishLabel;
@property(nonatomic,strong) UIButton  * publishBtn;
//粉丝数
@property(nonatomic,strong) MineArtView  * artView;
//普通用户
@property(nonatomic,strong) CommonUserView  *commonUserView;
//艺人
@property(nonatomic,strong) ArtUserView  *artUserView;
//商户
@property(nonatomic,strong) MerchantUserView  *merChantUser;
@property(nonatomic,copy)   ClickBlock  btnClick;
@property(nonatomic,assign) CGSize  size;
@property(nonatomic,strong) LoginModel  *model;
-(void)switchIndex:(NSInteger)index;
-(void)setModel:(LoginModel*)model;

@end

NS_ASSUME_NONNULL_END
