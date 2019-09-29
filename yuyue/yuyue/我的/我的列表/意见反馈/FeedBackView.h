//
//  FeedBackView.h
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYYTextView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(UIButton*btn);
@interface FeedBackView : UIView
@property(nonatomic,strong) UIImageView * bgcImg;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) LYYTextView  *contentTextView;
@property(nonatomic,strong) UILabel  *limitLabel;
@property(nonatomic,strong) UILabel *photoLabel;
@property(nonatomic,strong) UIButton  *photoBtn;
@property(nonatomic,strong) UILabel  *connectLabel;
@property(nonatomic,strong) UITextField  *textField;
@property(nonatomic,strong) UIButton  *commitBtn;
@property(nonatomic,copy) ClickBlock  click;
@end

NS_ASSUME_NONNULL_END
