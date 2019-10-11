//
//  BanKuanView.h
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^BaoKuanBlock)(UIButton *btn);
@interface BanKuanView : UIView
@property(nonatomic,strong) UIImageView  *iconImg;
@property(nonatomic,strong) UILabel  *iconLabel;
@property(nonatomic,strong) UIButton  *baoKuanBtn;
@property(nonatomic,strong) VideoModel  *model;
@property(nonatomic,copy) BaoKuanBlock  baoKuanClick;
-(void)setModel:(VideoModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
