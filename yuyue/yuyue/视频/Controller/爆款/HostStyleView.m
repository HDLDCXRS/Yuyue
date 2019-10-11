//
//  HostStyleView.m
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HostStyleView.h"

@implementation HostStyleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
             CGFloat min_w = 0;
            _bgcImage = [[UIImageView alloc] init];
            _bgcImage.image = [UIImage imageNamed:@"图"];
            [self addSubview:_bgcImage];
            [_bgcImage makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(0);
            }];
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"白色箭头"] forState:UIControlStateNormal];
        _backBtn.tag = 1;
        CGSize size = _backBtn.currentImage.size;
        [self addSubview:_backBtn];
        [_backBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Status_Height+19);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 18];
        _titleLabel.textColor = RGBA(255, 255, 255, 1);
        _titleLabel.text = @"爆款";
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backBtn.centerY);
            make.centerX.equalTo(self.centerX);
            make.size.equalTo(CGSizeMake(50, 60));
        }];
            _clothingLabel = [[UILabel alloc] init];
            _clothingLabel.text = @"连衣裙";
            min_w = [_clothingLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
            _clothingLabel.font = [UIFont fontWithName:@"PingFang SC" size: 10];
            _clothingLabel.textColor = [UIColor whiteColor];
            _clothingLabel.backgroundColor = RGBA(97, 97, 97, 0.62);
            _clothingLabel.layer.masksToBounds = YES;
            _clothingLabel.layer.cornerRadius = 5;
            _clothingLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_clothingLabel];
            [_clothingLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bgcImage.centerY);
                make.left.equalTo(self.bgcImage.left).offset(5);
                make.width.equalTo(min_w +10);
                make.height.equalTo(17);
            }];
            _clothingLabel2 = [[UILabel alloc] init];
            _clothingLabel2.text = @"夏季爆款女士连衣裙";
            min_w = [_clothingLabel2.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
            _clothingLabel2.font = [UIFont fontWithName:@"PingFang SC" size: 10];
            _clothingLabel2.textColor = [UIColor whiteColor];
            _clothingLabel2.backgroundColor = RGBA(97, 97, 97, 0.62);
            _clothingLabel2.layer.masksToBounds = YES;
            _clothingLabel2.layer.cornerRadius = 5;
            _clothingLabel2.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_clothingLabel2];
            [_clothingLabel2 makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.clothingLabel.bottom).offset(9);
                make.left.equalTo(self.bgcImage.left).offset(5);
                make.width.equalTo(min_w+10);
                make.height.equalTo(17);
            }];
            _priceLabel = [[UILabel alloc] init];
            _priceLabel.text = @"¥55";
            min_w = [_priceLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
            _priceLabel.font = [UIFont fontWithName:@"PingFang SC" size: 10];
            _priceLabel.textColor = [UIColor whiteColor];
            _priceLabel.backgroundColor = RGBA(97, 97, 97, 0.62);
            //        _priceLabel.layer.shadowColor = [UIColor blackColor].CGColor;
            _priceLabel.layer.masksToBounds = YES;
            _priceLabel.textAlignment = NSTextAlignmentCenter;
            _priceLabel.layer.cornerRadius = 5;
            [self addSubview:_priceLabel];
            [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.clothingLabel2.bottom).offset(9);
                make.left.equalTo(self.bgcImage.left).offset(5);
                make.width.equalTo(min_w+10);
                make.height.equalTo(17);
            }];
            _contentLabel = [[UILabel alloc] init];
            _contentLabel.text = @"¥55";
            
            min_w = [_contentLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
            _contentLabel.font = [UIFont fontWithName:@"PingFang SC" size: 10];
            _contentLabel.textColor = [UIColor whiteColor];
            _contentLabel.backgroundColor = RGBA(97, 97, 97, 0.62);
            _contentLabel.textAlignment = NSTextAlignmentCenter;
            _contentLabel.layer.masksToBounds = YES;
            _contentLabel.layer.cornerRadius = 5;
            [self addSubview:_contentLabel];
            [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.priceLabel.bottom).offset(9);
                make.left.equalTo(self.bgcImage.left).offset(5);
                make.width.equalTo(min_w +10);
                make.height.equalTo(17);
            }];
            _connectBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:RGBA(248, 116, 27, 1) setTitle:@"了解详情" setTitleColor:[UIColor whiteColor] state:UIControlStateNormal addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            _connectBtn.tag = 2;
            _connectBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 10];
            _connectBtn.layer.cornerRadius = 5;
            _connectBtn.layer.masksToBounds = YES;
            [self addSubview:_connectBtn];
            [_connectBtn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.bottom).offset(9);
                make.left.equalTo(self.bgcImage.left).offset(5);
                make.height.equalTo(17);
                make.width.equalTo(60);
            }];
    
    }
    return self;
}
-(void)onClick:(UIButton*)btn
{
    if (_backClick) {
        _backClick(btn);
    }
}
@end
