//
//  MineArtView.h
//  yuYue
//
//  Created by edz on 2019/8/20.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ArtClickBlock)(UIButton *btn);
@interface MineArtView : UIView
//粉丝
@property(nonatomic,strong) UILabel  * fansTitle;
@property(nonatomic,strong) UILabel  * fansCount;
// 点赞
@property(nonatomic,strong) UILabel  * clickTitle;
@property(nonatomic,strong) UILabel  * clickCount;
//评论
@property(nonatomic,strong) UILabel   * commentsTitle;
@property(nonatomic,strong) UILabel  * commentCount;
//收益
@property(nonatomic,strong) UIButton  * earningBtn;
@property(nonatomic,strong) UILabel  * earningCount;
@property(nonatomic,copy) ArtClickBlock  clickBtn;

@end

NS_ASSUME_NONNULL_END
