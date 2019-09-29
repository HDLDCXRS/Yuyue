//
//  MyAdvertisingTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAdvertiserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyAdvertisingTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView  *iconImage; //头像
@property(nonatomic,strong) UILabel  *iconLabel;     //昵称
@property(nonatomic,strong) UILabel  *statueLabel; //审核状态
//@property(nonatomic,strong) UILabel  *vipPriceLabel;  //会员信息
@property(nonatomic,strong) UIImageView  *bgcImage; // 背景图
@property(nonatomic,strong) UILabel  *clothingLabel;  //连衣裙
@property(nonatomic,strong) UILabel  *clothingLabel2; //夏季
@property(nonatomic,strong) UILabel  *priceLabel;   //  价格
@property(nonatomic,strong) UILabel  *contentLabel;  //清凉一夏值得拥有
@property(nonatomic,strong) UIButton  *connectBtn;
@property(nonatomic,strong) UILabel  *timeLabel;
@property(nonatomic,strong) MyAdvertiserModel  *model;
-(void)setModel:(MyAdvertiserModel *)model;

@end

NS_ASSUME_NONNULL_END
