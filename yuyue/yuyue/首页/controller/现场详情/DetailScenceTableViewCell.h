//
//  DetailScenceTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowSiteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailScenceTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel  *headLabel;  //标题
@property(nonatomic,strong) UIImageView  *contentImagView; //展示图
@property(nonatomic,strong) UIImageView  *timerImg;  //闹钟Label
@property(nonatomic,strong) UILabel  *entranceLabel; //入场时间
@property(nonatomic,strong) UILabel  *startTimeLabel;   //开场时间
@property(nonatomic,strong) UIImageView  *locationImage; //位置图片
@property(nonatomic,strong) UILabel  *siteLabel; //位置
@property(nonatomic,strong) UILabel  *locationLabel; //位置信息
@property(nonatomic,strong) UILabel* countLabel;   //共有多少人
@property(nonatomic,strong) UILabel  *timeLabel;  //时间
@property(nonatomic,strong) ShowSiteModel  *model;
-(void)setModel:(ShowSiteModel *)model;
@end

NS_ASSUME_NONNULL_END
