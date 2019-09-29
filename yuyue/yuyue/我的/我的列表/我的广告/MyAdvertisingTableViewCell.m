//
//  MyAdvertisingTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MyAdvertisingTableViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation MyAdvertisingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"头像2"];
        _iconImage.layer.cornerRadius = 20;
        _iconImage.layer.masksToBounds =YES;
        [self addSubview:_iconImage];
        [_iconImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(11);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        _statueLabel = [[UILabel alloc] init];
        _statueLabel.font = [UIFont fontWithName:@"PingFang SC" size: 11];
        [self addSubview:_statueLabel];
        [_statueLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.centerY);
            make.right.equalTo(-15);
            make.width.equalTo(45);
            make.height.equalTo(19);
        }];
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textColor = RGBA(51, 51, 51, 1);
        
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _iconLabel.text = @"她们都叫我小太阳";
        [self addSubview:_iconLabel];
        [_iconLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.right).offset(11);
            make.top.equalTo(17);
            make.height.equalTo(13);
            make.right.equalTo(self.statueLabel.left).offset(0);
        }];
        CGFloat min_w = 0;
        _bgcImage = [[UIImageView alloc] init];
        _bgcImage.image = [UIImage imageNamed:@"图"];
        [self addSubview:_bgcImage];
        [_bgcImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.bottom).offset(16);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(200, 304));
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
        _connectBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:RGBA(248, 116, 27, 1) setTitle:@"了解详情" setTitleColor:[UIColor whiteColor] state:UIControlStateNormal addTarget:self action:@selector(oClick:) forControlEvents:UIControlEventTouchUpInside];
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
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2019.02.11  13:34";
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _timeLabel.textColor =RGBA(102, 102, 102, 1);
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcImage.bottom).offset(7);
            make.left.equalTo(15);
            make.right.equalTo(0);
            make.height.equalTo(10);
        }];
    
    }
    return self;
}
-(void)setModel:(MyAdvertiserModel *)model
{

    [_iconImage sd_setImageWithURL:[[NSUserDefaults standardUserDefaults] valueForKey:@"headpUrl"]];
    _iconLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"];
   
   [_bgcImage sd_setImageWithURL:model.adImageUrl];

    _clothingLabel.text = model.category;
   CGFloat min_w = [_clothingLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
    [_clothingLabel updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(min_w+10);
    }];
    _clothingLabel2.text = model.commodityName;
    min_w = [_clothingLabel2.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:150].width;
    [_clothingLabel2 updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(min_w+10);
    }];
    _priceLabel.text = model.commodityPrice;
    min_w = [_priceLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
    [_priceLabel updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(min_w+10);
    }];
    _contentLabel.text = model.adWord;
    min_w = [ _contentLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 10] limitWidth:200].width;
    [ _contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(min_w+10);
    }];
    if([model.status isEqualToString:@"10A"])
    {
        //等待处理
        _statueLabel.textColor = RGBA(173,173,173,1);
        _statueLabel.text = @"审核中";
    }
    else if([model.status isEqualToString:@"10B"])
    {
        //处理成功
        _statueLabel.textColor = RGBA(26, 151, 224, 1);
       _statueLabel.text = @"已通过";
    }
    else
    {
       _statueLabel.textColor = RGBA(223, 34,34, 1);
       _statueLabel.text = @"未通过";
    }
    _timeLabel.text =model.applicationTime;
    
}

@end
