//
//  VideoCell.h
//  yuyue
//
//  Created by edz on 2019/10/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "AppUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoCell : UITableViewCell
@property(nonatomic,strong) UIImageView  *bgcImageView; //背景图
@property(nonatomic,strong) UILabel  *titleLabel; //标题
@property(nonatomic,strong) UIImageView  *iconImage; //头像
@property(nonatomic,strong) UILabel  *iconLabel;  //头像名字
@property(nonatomic,strong) UILabel  *commentLabel; // 评论名字
@property(nonatomic,strong) UILabel  *likeLabel;  //关注
//@property(nonatomic,strong) AppUserModel  *appUserModel;
@property(nonatomic,strong) VideoModel  *bgcModel;
-(void)setBgcModel:(VideoModel * _Nonnull)bgcModel;
//-(void)setAppUserModel:(AppUserModel * _Nonnull)appUserModel;

@end

NS_ASSUME_NONNULL_END
