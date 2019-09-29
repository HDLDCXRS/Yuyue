//
//  BaseView.h
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BtnBlock)(UIButton *btn);
@interface BaseView : UIView
@property(nonatomic,strong) UIImageView  * headImageView;
@property(nonatomic,strong) UIButton  * photoBtn;
@property(nonatomic,copy) BtnBlock   click;
@end

NS_ASSUME_NONNULL_END
