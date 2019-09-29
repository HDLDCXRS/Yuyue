//
//  MineCommonMoneyView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineCommonMoneyView.h"
#import "NSString+Size.h"
@implementation MineCommonMoneyView
- (instancetype)initWithFrame:(CGRect)frame setHeadTitle:(NSString *)headStr setBgcView:(NSString*)bgc setIconView:(NSString *)iconStr setTiTle:(NSString *)titleStr setContentLabel:(NSString *)contentStr setBtn:(NSString *)btnStr setBtnColor:(UIColor *)color
{
    self.backgroundColor = [UIColor whiteColor];
    self = [super initWithFrame:frame];
    if (self) {
        _mineLabel = [[UILabel alloc] init];
        _mineLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _mineLabel.textColor = RGBA(51, 51, 51, 1);
        _mineLabel.text = headStr;
        [self addSubview:_mineLabel];
        [_mineLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(21);
            make.height.equalTo(14);
            make.right.equalTo(0);
        }];
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:bgc];
        CGSize size = _imgView.image.size;
        [self addSubview:_imgView];
        [_imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mineLabel.bottom).offset(15);
            make.left.equalTo(15);
            make.height.equalTo(size.height);
            make.right.equalTo(-15);
        }];
        _headImgView  = [[UIImageView alloc ] init];
        _headImgView.image = [UIImage imageNamed:iconStr];
        size = _headImgView.image.size;
        [self addSubview:_headImgView];
        [_headImgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView.centerY);
            make.left.equalTo(self.imgView.left).offset(16);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = titleStr;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.top).offset(26);
            make.left.equalTo(self.headImgView.right).offset(18);
            make.height.equalTo(15);
            make.width.equalTo(60);
        }];
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.text = contentStr;
        CGFloat min_w = [_contentLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:200].width;
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(10);
            make.left.equalTo(self.headImgView.right).offset(18);
            make.width.equalTo(min_w);
            make.height.equalTo(13);
        }];
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"0";
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        [self addSubview:_countLabel];
        [_countLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.top).offset(22);
            make.right.equalTo(self.imgView.right).offset(-20);
            make.left.equalTo(0);
            make.height.equalTo(12);
        }];
        _coutntBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:btnStr setTitleColor:color state:UIControlStateNormal addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _coutntBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _coutntBtn.layer.masksToBounds = YES;
        _coutntBtn.layer.cornerRadius = 5;
        [self addSubview:_coutntBtn];
        [_coutntBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countLabel.bottom).offset(6);
            make.right.equalTo(self.imgView.right).offset(-12);
            make.height.equalTo(19);
            make.width.equalTo(38);
        }];
        
    }
    return self;
}
-(void)onClick:(UIButton *)btn
{
    if (_clickBtn) {
        _clickBtn(btn);
    }
}
@end
