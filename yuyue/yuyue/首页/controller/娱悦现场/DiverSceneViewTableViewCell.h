//
//  DiverSceneViewTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiverSceneModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DiverSceneViewTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel  *headLabel;
@property(nonatomic,strong) UIImageView  *contentImagView;
@property(nonatomic,strong) UIImageView  *loactionView; //
@property(nonatomic,strong) UILabel  *locationLabel; //位置信息
@property(nonatomic,strong) UILabel* countLabel;  //共有多少人
@property(nonatomic,strong) UILabel  *timeLabel;  //时间
@property(nonatomic,strong) DiverSceneModel  *model;
-(void)setModel:(DiverSceneModel *)model;
@end

NS_ASSUME_NONNULL_END
