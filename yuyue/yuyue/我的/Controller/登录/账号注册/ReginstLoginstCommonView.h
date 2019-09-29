//
//  ReginstLoginstCommonView.h
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TimeBlock)(UIButton *btn);
@interface ReginstLoginstCommonView : UIView
@property(nonatomic,strong)  UIImageView  * iconView ;
@property(nonatomic,strong)  UITextField  *inputTextField;
@property(nonatomic,strong)  UIImageView  *lineView;
@property(nonatomic,strong)  UIButton  *getCodeBtn;
/*
 * 定时器
 */
@property(nonatomic,copy) TimeBlock  click;
@property(strong,nonatomic) NSTimer *timer;

/*
 * 定时多少秒
 */
@property(assign,nonatomic) NSInteger count;
- (instancetype)initWithFrame:(CGRect)frame setImage:(NSString *)str setText:(NSString *)text getStuat:(BOOL)isShow;
- (void)timeFailBeginFrom:(NSInteger)timeCount;

@end

NS_ASSUME_NONNULL_END
