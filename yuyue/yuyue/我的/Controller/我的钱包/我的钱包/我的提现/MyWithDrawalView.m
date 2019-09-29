//
//  MyWithDrawalView.m
//  yuyue
//
//  Created by edz on 2019/9/25.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MyWithDrawalView.h"

@implementation MyWithDrawalView

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _moneyLabel.textColor = RGBA(51, 51, 51, 1);
        _moneyLabel.text =@"可提现金额";
    }
    return _moneyLabel;
}
- (UILabel *)applyLabel
{
    if (!_applyLabel) {
        _applyLabel = [[UILabel alloc] init];
        _applyLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _applyLabel.textColor = RGBA(51, 51, 51, 1);
        _applyLabel.text = @"申请提现金额";
    }
    return _applyLabel;
}
- (UILabel *)tixianLabel
{
    if (!_tixianLabel) {
        _tixianLabel = [[UILabel alloc] init];
        _tixianLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _tixianLabel.textColor = RGBA(51, 51, 51, 1);
        _tixianLabel.text = @"提现至";
    }
    return _tixianLabel;
}

- (UILabel *)jinELabel
{
    if (!_jinELabel) {
        _jinELabel = [[UILabel alloc] init];
        _jinELabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _jinELabel.textColor = RGBA(102, 102, 102, 1);
        _jinELabel.textAlignment = NSTextAlignmentRight;
        _jinELabel.text = @"¥100.00";
    }
    return _jinELabel;
}
- (UITextField *)appTextField
{
    if (!_appTextField) {
        self.appTextField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:@"请输入提现金额" clearsOnBeginEditing:YES andDelegate:self];
        self.appTextField.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        self.appTextField.textColor = RGBA(153, 153, 153, 1);
        self.appTextField.textAlignment = NSTextAlignmentRight;
    }
    return _appTextField;
}
- (UIImageView *)wxImage
{
    if (!_wxImage) {
        _wxImage = [[UIImageView alloc] init];
        _wxImage.image = [UIImage imageNamed:@"微信"];
    }
    return _wxImage;
}
- (UILabel *)weixinLabel
{
    if (!_weixinLabel) {
        _weixinLabel = [[UILabel alloc] init];
        _weixinLabel.text = @"微信";
        _weixinLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _weixinLabel.textColor = RGBA(153, 153, 153, 1);
    }
    return _weixinLabel;
}
- (UILabel *)titileLabel
{
    if (!_titileLabel) {
        _titileLabel = [[UILabel alloc] init];
        _titileLabel.text = @"注：目前仅支持微信提现";
        _titileLabel.textColor = RGBA(153, 153, 153, 1);
        _titileLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
    }
    return _titileLabel;
}
- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        self.commitBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"提现" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
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
    [self addSubview:self.moneyLabel];
    [self addSubview:self.jinELabel];
    [self addSubview:self.appTextField];
    [self addSubview:self.applyLabel];
    [self addSubview:self.tixianLabel];
    [self addSubview:self.weixinLabel];
    [self addSubview:self.wxImage];
    [self addSubview:self.titileLabel];
    [self addSubview:self.commitBtn];
    [self updateConstraintsForView];
    //self.backgroundColor = [UIColor whiteColor];
   
}

- (void)updateConstraintsForView
{
    UIImageView *bgcView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    bgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [self addSubview:bgcView];
    //可提现金额
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(26);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(80, 15));
    }];
    //提现金额
    [self.jinELabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(26);
        make.right.equalTo(-15);
        make.height.equalTo(12);
        make.left.equalTo(self.moneyLabel.right).offset(0);
    }];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = RGBA(241, 241, 241, 1);
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.bottom).offset(16);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
    }];
      //申请t
    [self.applyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(16);
        make.left.equalTo(15);
        make.width.equalTo(100);
        make.height.equalTo(15);
    }];
    //请输入金额
    [self.appTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(16);
        make.left.equalTo(self.applyLabel.right).offset(10);
        make.right.equalTo(-15);
        make.height.equalTo(20);
    }];
    //
    UIImageView *line1 = [[UIImageView alloc] init];
    line1.backgroundColor = RGBA(241, 241, 241, 1);
    [self addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appTextField.bottom).offset(16);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
    }];
    [self.tixianLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.bottom).offset(16);
        make.left.equalTo(15);
        make.width.equalTo(50);
        make.height.equalTo(15);
    }];
    [self.weixinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tixianLabel.centerY);
        make.right.equalTo(-15);
        make.height.equalTo(13);
        make.width.equalTo(30);
    }];
    CGSize size = self.wxImage.image.size;
    [self.wxImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tixianLabel.centerY);
        make.right.equalTo(self.weixinLabel.left).offset(-4);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    //提现至
    [self.titileLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxImage.bottom).offset(16);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(13);
    }];
    [self.commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titileLabel.bottom).offset(55);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(44);
    }];
}
-(void)onClickMethod:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}
@end
