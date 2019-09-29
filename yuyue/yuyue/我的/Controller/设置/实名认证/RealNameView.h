//
//  RealNameView.h
//  yuyue
//
//  Created by edz on 2019/9/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(UIButton *btn);
@interface RealNameView : UIView
@property(nonatomic,strong)  UILabel * nameLabel;  //姓名
@property(nonatomic,strong)  UITextField  *nameTextField;//姓名输入框
@property(nonatomic,strong) UILabel   *idLabel; //身份证号
@property(nonatomic,strong) UITextField  *idTextField;
@property(nonatomic,strong) UILabel  *idPhotoLabel;
@property(nonatomic,strong) UIButton * postRightPhotoBtn; //请上传身份证正面
@property(nonatomic,strong) UILabel  *postRightLabel;
@property(nonatomic,strong) UIButton  *postReversePhotoBtn; //请上传身份证反面
@property(nonatomic,strong) UILabel  *postReverseLabel;
@property(nonatomic,strong) UIButton  *postHandPhotoBtn;  //手持身份证
@property(nonatomic,strong) UILabel  *postHandPhotoLabel;
@property(nonatomic,strong) UIImageView  *footImgView;
@property(nonatomic,strong) UIButton  *commitBtn;
@property(nonatomic,copy) ClickBlock  click;

@end

NS_ASSUME_NONNULL_END
