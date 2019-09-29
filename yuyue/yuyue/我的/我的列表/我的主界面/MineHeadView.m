//
//  MineHeadView.m
//  yuYue
//
//  Created by edz on 2019/8/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineHeadView.h"
#import "UIImageView+WebCache.h"

@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置背景图
        //self.backgroundColor = RGBA(243, 243, 243, 1);
        _headView = [[UIImageView alloc] init];
        _headView.image = [UIImage imageNamed:@"矩形 4 拷贝 2"];
        CGSize imgSize = _headView.image.size;
        _headView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_headView];
        [_headView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(imgSize.height);
        }];
        //头像按钮
        _icomImg = [[UIImageView alloc] init];
        _icomImg.layer.masksToBounds =YES;
        _icomImg.layer.cornerRadius = 32;
        _icomImg.image = [UIImage imageNamed:@"头像"];
        [self addSubview:_icomImg];
        [_icomImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(64);
            make.left.equalTo(15);
            make.width.equalTo(64);
            make.height.equalTo(64);
        }];
        //注册登录
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 16];
        [_loginBtn.titleLabel setTextColor:[UIColor whiteColor]];
        _loginBtn.tag = 1;
        [_loginBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.icomImg.centerY);
            make.left.equalTo(self.icomImg.right).offset(12);
            make.height.equalTo(16);
            make.width.equalTo(80);
            
        }];
       

        //设置
        _SetUpBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"设置 (1)"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _SetUpBtn.tag = 2;
        CGSize setUpSize = _SetUpBtn.currentBackgroundImage.size;
        [self addSubview:_SetUpBtn];
        [_SetUpBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Status_Height + 15);
            make.right.equalTo(-15);
            make.width.equalTo(setUpSize.width);
            make.height.equalTo(setUpSize.height);
        }];
        //

        _commonUserView = [[CommonUserView alloc] init];
        [self addSubview:_commonUserView];
        [_commonUserView.scanBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
         [_commonUserView.mineMoneyBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
       // _commonUserView.userInteractionEnabled =YES;
        [_commonUserView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headView.bottom).offset(-20);
            make.left.equalTo(42);
            make.right.equalTo(-42);
            make.height.equalTo(100);
        }];
        _artView = [[MineArtView alloc] init];
        [self addSubview:_artView];
        [_artView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.icomImg.bottom).offset(16);
            make.left.right.equalTo(0);
            make.height.equalTo(35);
        }];
        // 艺人
        _artUserView = [[ArtUserView alloc] init];
        [self addSubview:_artUserView];
        [_artUserView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.artView.bottom).offset(16);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(100);
        }];
        [_artUserView.scanBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_artUserView.mineMoneyBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_artUserView.minePublish addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _merChantUser = [[MerchantUserView alloc] init];
        [self addSubview:_merChantUser];
        [_merChantUser makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.artView.bottom).offset(15);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(100);
        }];
        [_merChantUser.scanBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_merChantUser.mineMoneyBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_merChantUser.minePublish addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_merChantUser.merchantBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self switchIndex:1];
    }
    return self;
}
-(void)switchIndex:(NSInteger)index
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"])
    {
        [_loginBtn setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"] forState:UIControlStateNormal];
        _loginBtn.userInteractionEnabled =NO;
//        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"headpUrl"]) {
//            _icomImg.image = [UIImage imageNamed:@"头像"];
//        }
//        else
//        {
        [_icomImg sd_setImageWithURL:[[NSUserDefaults standardUserDefaults] valueForKey:@"headpUrl"]];
      //  }
    }
    else
    {
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
         _loginBtn.userInteractionEnabled =YES;
         _icomImg.image = [UIImage imageNamed:@"头像"];
    }
    
    switch (index) {
        case 0:
            _artView.hidden = YES;
            _artUserView.hidden = YES;
            _merChantUser.hidden = YES;
            _commonUserView.hidden = NO;
            break;
        case 1:
            _artView.hidden = YES;
            _artUserView.hidden = YES;
            _merChantUser.hidden = YES;
            _commonUserView.hidden = NO;
            break;
        case 2:
            _artView.hidden = NO;
            _artUserView.hidden = NO;
            _commonUserView.hidden =YES;
            _merChantUser.hidden = YES;
            break;
        case 3:
            _artView.hidden = NO;
            _artUserView.hidden = YES;
            _commonUserView.hidden =YES;
            _merChantUser.hidden = NO;
            break;
        case 4:
            _artView.hidden = NO;
            _artUserView.hidden = YES;
            _commonUserView.hidden =YES;
            _merChantUser.hidden = NO;
            break;
        default:
            break;
    }
}
-(void)onClick:(UIButton *)btn
{
    if (_btnClick) {
        _btnClick(btn.tag);
    }
}

-(void)setModel:(LoginModel*)model
{
    _artView.fansCount.text = model.likeTotal;
    _artView.clickCount.text = model.attentionTotal;
    _artView.commentCount.text = model.commentTotal;
    _artView.earningCount.text = [NSString stringWithFormat:@"%.2f",model.income];
    [_icomImg sd_setImageWithURL:model.headpUrl];
    _loginBtn.userInteractionEnabled = NO;
    [_loginBtn setTitle:model.nickName forState:UIControlStateNormal];
}
@end
