//
//  RealNameView.m
//  yuyue
//
//  Created by edz on 2019/9/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RealNameView.h"
#import "NSString+Size.h"
@implementation RealNameView
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text =@"姓名";
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _nameLabel.textColor = RGBA(51, 51, 51, 1);
       
    }
    return _nameLabel;
}
- (UITextField *)nameTextField
{
    if (!_nameTextField) {
         _nameTextField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:@"请填写姓名" clearsOnBeginEditing:YES andDelegate:self];
        _nameTextField.textColor = RGBA(153, 153, 153, 1);
        _nameTextField.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    }
    return _nameTextField;
}
- (UILabel *)idLabel
{
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.text =@"身份证号";
        _idLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _idLabel.textColor = RGBA(51, 51, 51, 1);
    }
    return _idLabel;
    
}
- (UITextField *)idTextField
{
    if (!_idTextField) {
        _idTextField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:@"请填写身份证号" clearsOnBeginEditing:YES andDelegate:self];
        _idTextField.textColor = RGBA(153, 153, 153, 1);
        _idTextField.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    }
    return _idTextField;
   
}
- (UILabel *)idPhotoLabel
{
    if (!_idPhotoLabel) {
        _idPhotoLabel = [[UILabel alloc] init];
        _idPhotoLabel.text =@"请拍摄并上传你的身份证照片";
        _idPhotoLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _idPhotoLabel.textColor = RGBA(27, 27, 32, 1);
        
    }
    return _idPhotoLabel;
}
- (UIButton *)postRightPhotoBtn
{
    if (!_postRightPhotoBtn) {
        _postRightPhotoBtn = [UIButton buttonWithNormalImage:@"身份证正面" highlightedImage:nil addTarget:self action:@selector(selectorPhoton:)];
        _postRightPhotoBtn.tag = 1;
    }
    return _postRightPhotoBtn;
}
- (UILabel *)postRightLabel
{
    if (!_postRightLabel) {
        _postRightLabel = [[UILabel alloc] init];
        _postRightLabel.text =@"请上传身份证正面";
        _postRightLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _postRightLabel.textColor = RGBA(51, 51, 51, 1);
        _postRightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _postRightLabel;
}
- (UIButton *)postReversePhotoBtn
{
    if (!_postReversePhotoBtn) {
        _postReversePhotoBtn = [UIButton buttonWithNormalImage:@"身份证反面" highlightedImage:nil addTarget:self action:@selector(selectorPhoton:)];
        _postReversePhotoBtn.tag = 2;
    }
    return _postReversePhotoBtn;
}
- (UILabel *)postReverseLabel
{
    if (!_postReverseLabel) {
        _postReverseLabel = [[UILabel alloc] init];
        _postReverseLabel.text =@"请上传身份证反面";
        _postReverseLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _postReverseLabel.textColor = RGBA(51, 51, 51, 1);
        _postReverseLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _postReverseLabel;
}
- (UIButton *)postHandPhotoBtn
{
    if (!_postHandPhotoBtn) {
        _postHandPhotoBtn = [UIButton buttonWithNormalImage:@"手持身份证" highlightedImage:nil addTarget:self action:@selector(selectorPhoton:)];
        _postHandPhotoBtn.tag = 3;
    }
    return _postHandPhotoBtn;
}
- (UILabel *)postHandPhotoLabel
{
    if (!_postHandPhotoLabel) {
        _postHandPhotoLabel = [[UILabel alloc] init];
        _postHandPhotoLabel.text =@"请上传手持身份证照片";
        _postHandPhotoLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _postHandPhotoLabel.textColor = RGBA(51, 51, 51, 1);
        _postHandPhotoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _postHandPhotoLabel;
}
- (UIImageView *)footImgView
{
    if (!_footImgView) {
        _footImgView = [[UIImageView alloc] init];
        _footImgView.image = [UIImage imageNamed:@"提示"];
    }
    return _footImgView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameTextField];
    [self addSubview:self.idLabel];
    [self addSubview:self.idTextField];
    [self addSubview:self.idPhotoLabel];
    [self addSubview:self.postRightPhotoBtn];
    [self addSubview:self.postRightLabel];
    [self addSubview:self.postReversePhotoBtn];
    [self addSubview:self.postReverseLabel];
    [self addSubview:self.postHandPhotoBtn];
    [self addSubview:self.postHandPhotoLabel];
    [self addSubview:self.footImgView];
    [self updateConstraintsForView];
}
-(void)updateConstraintsForView
{
    //
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    imgView.backgroundColor = RGBA(243, 243, 243, 1);
    [self addSubview:imgView];
    CGFloat min_w = [self.nameLabel.text  textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:60].width;
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.bottom).offset(15);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(min_w, 14));
    }];
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.bottom).offset(16);
        make.left.equalTo(self.nameLabel.right).offset(76);
        make.height.equalTo(13);
        make.right.equalTo(0);
    }];
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = RGBA(230, 230, 230, 1);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.bottom).offset(13);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(1);
        make.left.equalTo(0);
    }];
    min_w = [self.idLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:60].width;
    [self.idLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(15);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(min_w, 14));
    }];
    [self.idTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.nameTextField.centerX);
        make.height.equalTo(13);
        make.top.equalTo(lineView.bottom).offset(16);
        make.right.equalTo(0);
    }];
    UIImageView *centerView = [[UIImageView alloc] init];
    centerView.backgroundColor = RGBA(243, 243, 243, 1);
    [self addSubview:centerView];
    [centerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idTextField.bottom).offset(13);
        make.right.left.equalTo(0);
        make.height.equalTo(10);
    }];
    min_w = [self.idPhotoLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:SCREENWIDTH].width;
    [self.idPhotoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.bottom).offset(19);
        make.size.equalTo(CGSizeMake(min_w, 14));
        make.left.equalTo(16);
    }];
    CGSize  size =  self.postRightPhotoBtn.currentImage.size;
    [self.postRightPhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idPhotoLabel.bottom).offset(19);
        make.left.equalTo(14);
        make.size.equalTo(CGSizeMake(size.width,size.height));
    }];
    min_w = [self.postRightLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 12] limitWidth:(SCREENWIDTH-62)/2].width;
    [self.postRightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.postRightPhotoBtn.centerX);
        make.top.equalTo(self.postRightPhotoBtn.bottom).offset(7);
        make.size.equalTo(CGSizeMake(min_w, 12));
    }];
    size =self.postReversePhotoBtn.currentImage.size;
    [self.postReversePhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idPhotoLabel.bottom).offset(19);
        make.right.equalTo(-14);
        make.size.equalTo(CGSizeMake(size.width,size.height));
    }];
    [self.postReverseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.postReversePhotoBtn.centerX);
        make.top.equalTo(self.postRightPhotoBtn.bottom).offset(7);
        make.size.equalTo(CGSizeMake(min_w, 12));
    }];
    //手持身份证
    size = self.postHandPhotoBtn.currentImage.size;
    [self.postHandPhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postReverseLabel.bottom).offset(24);
        make.left.equalTo(14);
        make.size.equalTo(CGSizeMake(size.width,size.height));
    }];
    min_w = [self.postHandPhotoLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 12] limitWidth:SCREENWIDTH].width;
    [self.postHandPhotoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postHandPhotoBtn.bottom).offset(24);
        make.centerX.equalTo(self.postHandPhotoBtn.centerX);
        make.size.equalTo(CGSizeMake(min_w, 12));
    }];
    UIImageView *lastBgcView = [[UIImageView alloc] init];
    lastBgcView.backgroundColor = RGBA(230, 230, 230, 1);
    [self addSubview:lastBgcView];
    [lastBgcView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postHandPhotoLabel.bottom).offset(20);
       // make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(10);
        make.left.right.equalTo(0);
    }];
    size =self.footImgView.image.size;
    [self.footImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastBgcView.bottom).offset(21);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
}
-(void)selectorPhoton:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}

@end

