//
//  HostStyleView.h
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BackBlock)(UIButton *btn);
@interface HostStyleView : UIView
@property(nonatomic,strong) UIButton  *backBtn;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UIImageView  *bgcImage; // 背景图
@property(nonatomic,strong) UILabel  *clothingLabel;  //连衣裙
@property(nonatomic,strong) UILabel  *clothingLabel2; //夏季
@property(nonatomic,strong) UILabel  *priceLabel;   //  价格
@property(nonatomic,strong) UILabel  *contentLabel;  //清凉一夏值得拥有
@property(nonatomic,strong) UIButton  *connectBtn;
@property(nonatomic,copy)BackBlock   backClick;

@end

NS_ASSUME_NONNULL_END
