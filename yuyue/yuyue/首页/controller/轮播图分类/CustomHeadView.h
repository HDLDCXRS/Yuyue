//
//  CustomHeadView.h
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeLocationBtn.h"
#import "MainADView.h"
#import "SpeedView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomHeadView : UIButton
@property(nonatomic,strong) CustomeLocationBtn  *locationBtn;
@property(nonatomic,strong) MainADView  *mainADView;
@property(nonatomic,strong) SpeedView   *speedView;

@end

NS_ASSUME_NONNULL_END
