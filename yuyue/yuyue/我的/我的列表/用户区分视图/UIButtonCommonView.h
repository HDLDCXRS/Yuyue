//
//  UIButtonCommonView.h
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButtonCommonView : UIButton
@property(nonatomic,strong) UIImageView  *iconBtn;
@property(nonatomic,strong) UILabel  * contentLabel;
- (instancetype)initWithFrame:(CGRect)frame setBtnImg:(NSString *)str  Title:(NSString *)strA;
@end

NS_ASSUME_NONNULL_END
