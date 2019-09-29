//
//  RechangCustomView.h
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechangCommonBtn.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^MyBlock)(RechangCommonBtn *btn);
@interface RechangCustomView : UIView
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UILabel  *smallLabel;
@property(nonatomic,strong) RechangCommonBtn  *combtnOne;
@property(nonatomic,strong) RechangCommonBtn  *combtnTwo;
@property(nonatomic,strong) RechangCommonBtn  *combtnThree;
@property(nonatomic,strong) RechangCommonBtn  *combtnFour;
@property(nonatomic,strong) RechangCommonBtn  *combtnFive;
@property(nonatomic,strong) RechangCommonBtn  *combtnSix;
@property(nonatomic,copy) MyBlock  clickBlock;
@end

NS_ASSUME_NONNULL_END
