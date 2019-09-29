//
//  MineCommonMoneyView.h
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(UIButton * btn);
@interface MineCommonMoneyView : UIView
@property(nonatomic,strong) UILabel  *mineLabel;
@property(nonatomic,strong) UIImageView  *imgView;
@property(nonatomic,strong) UIImageView  *headImgView;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UILabel  *contentLabel;
@property(nonatomic,strong) UILabel * countLabel;
@property(nonatomic,strong) UIButton  *coutntBtn;
@property(nonatomic,copy)   ClickBlock clickBtn;
- (instancetype)initWithFrame:(CGRect)frame setHeadTitle:(NSString *)headStr setBgcView:(NSString*)bgc setIconView:(NSString *)iconStr setTiTle:(NSString *)titleStr setContentLabel:(NSString *)contentStr setBtn:(NSString *)btnStr setBtnColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
