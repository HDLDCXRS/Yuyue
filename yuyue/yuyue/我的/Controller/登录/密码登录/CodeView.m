//
//  CodeView.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CodeView.h"

@implementation CodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photoImg = [UIImageView imageViewWithFrame:CGRectZero imageName:@"手机"];
        CGSize size = _photoImg.image.size;
        [self addSubview:_photoImg];
        [_photoImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(40);
            make.width.equalTo(size.width);
            make.height.equalTo(size.height);
        }];
        _photoTextField = [UITextField textFieldWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] secureTextEntry:YES placeholder:@"手机号" clearsOnBeginEditing:YES andDelegate:self]; 
        _photoTextField.secureTextEntry = NO;
        _photoTextField.textColor = RGBA(133, 133, 133, 1);
        [self addSubview:_photoTextField];
        [_photoTextField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(self.photoImg.right).offset(16);
            make.right.equalTo(-40);
            make.height.equalTo(size.height);
        }];
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = RGBA(133, 133, 133, 1);
        [self addSubview:lineLabel];
        [lineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.right.equalTo(-37);
            make.height.equalTo(1);
            make.top.equalTo(self.photoTextField.bottom).offset(12);
        }];
        //请输入密码
        _lockImage = [UIImageView imageViewWithFrame:CGRectZero imageName:@"锁"];
        size =_lockImage.image.size;
        [self addSubview:_lockImage];
        [_lockImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(38);
            make.left.equalTo(40);
            make.width.equalTo(size.width);
            make.height.equalTo(size.height);
        }];
        
        _passwordTextField = [UITextField textFieldWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] secureTextEntry:YES placeholder:@"请输入密码" clearsOnBeginEditing:YES andDelegate:self];
        _passwordTextField.textColor = RGBA(133, 133, 133, 1);
        [self addSubview:_passwordTextField];
        [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(38);
            make.left.equalTo(self.lockImage.right).offset(16);
            make.right.equalTo(-100);
            make.height.equalTo(size.height);
        }];
        UILabel *codeLabel = [[UILabel alloc] init];
        codeLabel.backgroundColor = RGBA(133, 133, 133, 1);
        [self addSubview:codeLabel];
        [codeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.right.equalTo(-37);
            make.height.equalTo(1);
            make.top.equalTo(self.passwordTextField.bottom).offset(12);
        }];
//        //获取验证码
//        
        _forgetPasswordBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:@"忘记密码" setTitleColor:RGBA(133, 133, 133, 1)state:UIControlStateNormal addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _forgetPasswordBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _forgetPasswordBtn.tag = 0;
        [self addSubview:_forgetPasswordBtn];
        [_forgetPasswordBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(37);
            make.right.equalTo(-45);
            make.width.equalTo(100);
            make.height.equalTo(13);
        }];
        _loginBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"登录" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 1 拷贝 2"] forState:UIControlStateSelected];
        _loginBtn.tag = 1;
        size = _loginBtn.currentBackgroundImage.size;
        [self addSubview:_loginBtn];
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(codeLabel.bottom).offset(48);
            make.left.equalTo(40);
            make.right.equalTo(-40);
            make.height.equalTo(size.height);
        }];
        
    }
    return self;
}
-(void)onClick:(UIButton *)btn
{
    if (_clickBlock) {
        _clickBlock(btn.tag);
    }
}
@end
