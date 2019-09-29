//
//  PublisVideoView.h
//  yuyue
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyBlock)(UIButton *btn);
@interface PublisVideoView : UIView
@property(nonatomic,strong) UIImageView  *bgcImgView;
@property(nonatomic,strong) UIButton  *selectBtn; //选择图片
@property(nonatomic,copy) MyBlock  onClickBtn;
@end

NS_ASSUME_NONNULL_END
