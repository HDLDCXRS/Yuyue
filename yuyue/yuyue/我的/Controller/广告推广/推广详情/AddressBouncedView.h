//
//  AddressBouncedView.h
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^Myblock)(UIButton * _Nonnull btn);
NS_ASSUME_NONNULL_BEGIN
@interface AddressBouncedView : UIView
@property(nonatomic,strong) UILabel  *siteLabe;
@property(nonatomic,strong) UIButton  *cancleBtn;
@property(nonatomic,strong) UILabel  *selectLabel;
@property(nonatomic,strong) UIButton  *jiantouBtn;
@property(nonatomic,strong) UITextField  *detailField;
@property(nonatomic,strong) UIButton  *saveBtn;
@property(nonatomic,copy) Myblock  click;

@end

NS_ASSUME_NONNULL_END
