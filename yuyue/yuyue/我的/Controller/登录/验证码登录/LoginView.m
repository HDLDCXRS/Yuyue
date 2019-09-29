//
//  LoginView.m
//  yuYue
//
//  Created by edz on 2019/8/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
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
        _photoTextField = [UITextField textFieldWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] secureTextEntry:YES placeholder:@"输入手机号" clearsOnBeginEditing:YES andDelegate:self];
        _photoTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 15];
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
      //请输入验证码
        _photoCodeImg = [UIImageView imageViewWithFrame:CGRectZero imageName:@"锁"];
        size =_photoCodeImg.image.size;
        [self addSubview:_photoCodeImg];
        [_photoCodeImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(38);
            make.left.equalTo(40);
            make.width.equalTo(size.width);
            make.height.equalTo(size.height);
        }];
        
        //
        _photoCodeTextField = [UITextField textFieldWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] secureTextEntry:YES placeholder:@"请输入验证码" clearsOnBeginEditing:YES andDelegate:self];
        _photoCodeTextField.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 15];
        _photoCodeTextField.textColor = RGBA(133, 133, 133, 1);
        [self addSubview:_photoCodeTextField];
        [_photoCodeTextField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(38);
            make.left.equalTo(self.photoCodeImg.right).offset(16);
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
            make.top.equalTo(self.photoCodeTextField.bottom).offset(12);
        }];
      //获取验证码
        _getImgBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:@"获取验证码" setTitleColor:RGBA(26, 151, 224, 1) state:UIControlStateNormal addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _getImgBtn.tag = 0;
        _getImgBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _getImgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_getImgBtn];
        [_getImgBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.bottom).offset(37);
            make.right.equalTo(-45);
            make.width.equalTo(100);
            make.height.equalTo(13);
        }];
        //登录
        _loginingBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"登录" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loginingBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateHighlighted];
         _loginingBtn.tag = 1;
        size = _loginingBtn.currentBackgroundImage.size;
        [self addSubview:_loginingBtn];
        [_loginingBtn makeConstraints:^(MASConstraintMaker *make) {
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
- (void)timeFailBeginFrom:(NSInteger)timeCount
{
    self.count = timeCount;
    self.getImgBtn.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
}
#pragma mark - 定时器事件
- (void)timeDown
{
    if (self.count != 1){
        
        self.count -=1;
        self.getImgBtn.enabled = NO;
        [self.getImgBtn setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateNormal];
        
    } else {
        
        self.getImgBtn.enabled = YES;
        [self.getImgBtn setTitle:@"再次获取" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}
@end
