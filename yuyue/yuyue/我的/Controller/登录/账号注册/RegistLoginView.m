//
//  RegistLoginView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RegistLoginView.h"
#import "NSString+Size.h"
@implementation RegistLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = RGBA(51, 51, 51, 1);
        _titleLabel.text = @"账号注册";
        CGFloat min_w = [_titleLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:SCREENWIDTH].width;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(min_w);
            make.height.equalTo(14);
        }];
        _reginstView_one = [[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"手机" setText:@"请输入手机号" getStuat:NO];
        [self addSubview:_reginstView_one];
        [_reginstView_one makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(27);
            make.left.right.equalTo(0);
            make.height.equalTo(70);
        }];
        _reginstView_two =[[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"验证码" setText:@"请输入验证码" getStuat:YES];
        [self addSubview:_reginstView_two];
        [_reginstView_two makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_one.bottom).offset(0);
            make.left.right.equalTo(0);
            make.height.equalTo(70);
        }];
        _reginstView_three = [[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"锁" setText:@"请输入密码" getStuat:NO];
        [self addSubview:_reginstView_three];
        [_reginstView_three makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_two.bottom).offset(0);
            make.left.right.equalTo(0);
            make.height.equalTo(70);
        }];
        _reginstView_four = [[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"锁" setText:@"请再次输入密码" getStuat:NO];
        [self addSubview:_reginstView_four];
        [_reginstView_four makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_three.bottom).offset(0);
            make.left.right.equalTo(0);
            make.height.equalTo(70);
        }];
        
        _iconBtn = [UIButton buttonWithNormalImage:@"默认" highlightedImage:@"选中" addTarget:self action:@selector(onClick:)];
        [_iconBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        _iconBtn.tag =1;
        [self addSubview:_iconBtn];
        [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_four.bottom).offset(5);
//            make.centerX.equalTo(self.centerX);
            make.left.equalTo(102);
            make.size.equalTo(CGSizeMake(9, 9));
        }];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意用户协议" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
                                             
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11]} range:NSMakeRange(0, 7)];
                                             
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11], NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:151/255.0 blue:224/255.0 alpha:1.0]} range:NSMakeRange(7, 4)];
        _headLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _headLabel.tag = 10;
        [_headLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headLabel setAttributedTitle:string forState:UIControlStateNormal];
        [self addSubview:_headLabel];
        [_headLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_four.bottom).offset(5);
            make.left.equalTo(self.iconBtn.right).offset(5);
            make.width.equalTo(123);
            make.height.equalTo(11);
        }];
        
        //
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"和隐私政策" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        [string2 addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11]} range:NSMakeRange(0, 1)];
        
        [string2 addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11], NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:151/255.0 blue:224/255.0 alpha:1.0]} range:NSMakeRange(1, 4)];
        _userLabel = [UIButton buttonWithType:UIButtonTypeCustom];;
        [_userLabel setAttributedTitle:string2 forState:UIControlStateNormal];
        [_userLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _userLabel.tag = 11;
        _userLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_userLabel];
        [_userLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reginstView_four.bottom).offset(5);
            make.left.equalTo(self.headLabel.right).offset(0);
            make.right.equalTo(0);
            make.height.equalTo(11);
        }];
        _footerBtn  = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"注册" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _footerBtn.tag =2;
        [self addSubview:_footerBtn];
        [_footerBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-125);
            make.left.equalTo(39);
            make.right.equalTo(-39);
            make.height.equalTo(44);
        }];
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont fontWithName:@"PingFang SC" size: 11];
        _companyLabel.textColor = RGBA(51, 51, 51, 1);
        _companyLabel.text = @"版权属于  杭州和元网络科技有限公司";
        [self addSubview:_companyLabel];
        [_companyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-25);
            make.centerX.equalTo(self.centerX);
            make.height.equalTo(11);
        }];
    }
    return self;
}
-(void)onClick:(UIButton *)btn
{
    if (_click) {
        _click(btn.tag);
    }
}
@end
