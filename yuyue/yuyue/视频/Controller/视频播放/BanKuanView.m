//
//  BanKuanView.m
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BanKuanView.h"

@implementation BanKuanView
//@property(nonatomic,strong) UIImageView  *iconImg;
//@property(nonatomic,strong) UILabel  *iconLabel;
//@property(nonatomic,strong) UIButton  *baoKuanBtn;
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
    }
    return _iconImg;
}
- (UILabel *)iconLabel
{
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _iconLabel.text = @"冬天的小阳光";
    }
    return _iconLabel;
}
- (UIButton *)baoKuanBtn
{
    if (!_baoKuanBtn) {
        _baoKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baoKuanBtn setImage:[UIImage imageNamed:@"爆款"] forState:UIControlStateNormal];
        [_baoKuanBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _baoKuanBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    [self addSubview:self.iconImg];
    [self addSubview:self.iconLabel];
    [self addSubview:self.baoKuanBtn];
    [self updateConstraintsForView];
}
- (void)updateConstraintsForView
{
    [self.iconImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(7);
        make.left.equalTo(15);
        make.width.equalTo(23);
        make.height.equalTo(23);
    }];
    [self.iconLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImg.centerY);
        make.left.equalTo(self.iconImg.right).offset(2);
        make.height.equalTo(13);
        make.width.equalTo(100);
    }];
    [self.baoKuanBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImg.centerY);
        make.right.equalTo(-15);
        make.size.equalTo(CGSizeMake(22, 25));
    }];
    UIImageView *lineView =[[UIImageView alloc] init];
    lineView.backgroundColor = RGBA(243, 243, 243, 1);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImg.bottom).offset(15);
        make.left.right.equalTo(0);
        make.height.equalTo(10);
    }];
    UILabel *hostLabel = [[UILabel alloc] init];
    hostLabel.text =@"热门评论";
    hostLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    [self addSubview:hostLabel];
    [hostLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(15);
        make.left.equalTo(15);
        make.right.equalTo(0);
        make.height.equalTo(14);
    }];
}
- (void)setModel:(VideoModel *)model
{
     [_iconImg sd_setImageWithURL:model.appUser.headpUrl];
     _iconLabel.text = model.appUser.nickName;
}
-(void)onClick:(UIButton*)btn
{
    if (_baoKuanClick) {
        _baoKuanClick(btn);
    }
}
@end
