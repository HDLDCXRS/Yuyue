//
//  DetailScenceTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DetailScenceTableViewCell.h"
#import "NSString+Size.h"
#import <UIImageView+AFNetworking.h>
@implementation DetailScenceTableViewCell

-(UILabel*)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.numberOfLines = 2;
        _headLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _headLabel.textColor = RGBA(51, 51, 51, 1);
        _headLabel.text = @"金星跳舞多厉害，一段舞蹈惊艳全场，足以让你爱上她";
    }
    return _headLabel;
}
-(UIImageView *)contentImagView
{
    if (!_contentImagView) {
        _contentImagView = [[UIImageView alloc] init];
        _contentImagView.image = [UIImage imageNamed:@"图层 1"];
    }
    return _contentImagView;
}
- (UIImageView *)timerImg
{
    if (!_timerImg) {
        _timerImg = [[UIImageView alloc] init];
        _timerImg.image = [UIImage imageNamed:@"时间"];
    }
    return _timerImg;
}
//入场时间
- (UILabel *)entranceLabel
{
    if (!_entranceLabel) {
        _entranceLabel = [[UILabel alloc] init];
        _entranceLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _entranceLabel.text = @" 入场时间:2019-7-12  14:00";
        _entranceLabel.textColor = RGBA(51, 51, 51, 1);
    }
    return _entranceLabel;
}
//多少人
- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.text = @"(20/50人)";
        _countLabel.textColor = RGBA(102, 102, 102, 1);
    }
    return _countLabel;
}
//开场时间
- (UILabel *)startTimeLabel
{
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _startTimeLabel.text = @" 入场时间:2019-7-12  14:00";
        _startTimeLabel.textColor = RGBA(51, 51, 51, 1);
    }
    return _startTimeLabel;
}

- (UIImageView *)locationImage
{
    if (!_locationImage) {
        _locationImage = [[UIImageView alloc] init];
        _locationImage.image = [UIImage imageNamed:@"定位"];
    }
    return _locationImage;
}
//位置信息
- (UILabel *)siteLabel
{
    if (!_siteLabel) {
        _siteLabel = [[UILabel alloc] init];
        _siteLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _siteLabel.textColor = RGBA(51, 51, 51, 1);
        _siteLabel.text = @"东方艺术中心音乐厅";
    }
    return _siteLabel;
}
//-(UILabel*)locationLabel
//{
//    if (!_locationLabel) {
//        _locationLabel = [[UILabel alloc] init];
//        _locationLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
//        _locationLabel.textColor = RGBA(153, 153, 153, 1);
//        _locationLabel.text = @"上海市浦东区丁香路23号";
//    }
//    return _locationLabel;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUI];
    }
    return  self;
}
-(void)setUI
{
    [self addSubview:self.headLabel];
    [self addSubview:self.contentImagView];
    [self addSubview:self.timerImg];
    [self addSubview:self.entranceLabel];
    [self addSubview:self.startTimeLabel];
    [self addSubview:self.locationImage];
    [self addSubview:self.siteLabel];
   // [self addSubview:self.locationLabel];
    [self addSubview:self.countLabel];
    [self updateConstraintsForView];
}
-(void)updateConstraintsForView
{
    [self.headLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(15);
        make.width.equalTo(SCREENWIDTH-62);
        make.height.equalTo(51);
    }];
    [self.contentImagView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headLabel.bottom).offset(10);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(191);
    }];
    CGSize size = _timerImg.image.size;
    [self.timerImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImagView.bottom).offset(13);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    [self.entranceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timerImg.centerY);
        make.left.equalTo(self.timerImg.right).offset(12);
        make.right.equalTo(0);
        make.height.equalTo(14);
    }];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.entranceLabel.centerY);
        make.right.equalTo(-15);
        make.left.equalTo(0);
        make.height.equalTo(13);
    }];
    [self.startTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.entranceLabel.bottom).offset(12);
        make.left.equalTo(self.timerImg.right).offset(12);
        make.right.equalTo(0);
        make.height.equalTo(14);
    }];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = RGBA(230, 230, 230, 1);
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeLabel.bottom).offset(15);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(1);
    }];
    
    size = self.locationImage.image.size;
    [self.locationImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(12);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    [self.siteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationImage.centerY);
        make.left.equalTo(self.locationImage.right).offset(12);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 14));
    }];
//    [self.locationLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.siteLabel.bottom).offset(12);
//        make.left.equalTo(self.locationImage.right).offset(12);
//        make.size.equalTo(CGSizeMake(SCREENWIDTH, 14));
//    }];
    
 
}
-(void)setModel:(ShowSiteModel *)model;
{
//    @property(nonatomic,strong) UILabel  *headLabel;  //标题
//    @property(nonatomic,strong) UIImageView  *contentImagView; //展示图
//    @property(nonatomic,strong) UIImageView  *timerImg;  //闹钟Label
//    @property(nonatomic,strong) UILabel  *entranceLabel; //入场时间
//    @property(nonatomic,strong) UILabel  *startTimeLabel;   //开场时间
//    @property(nonatomic,strong) UIImageView  *locationImage; //位置图片
//    @property(nonatomic,strong) UILabel  *siteLabel; //位置
//    @property(nonatomic,strong) UILabel  *locationLabel; //位置信息
//    @property(nonatomic,strong) UILabel* countLabel;   //共有多少人
//    @property(nonatomic,strong) UILabel  *timeLabel;  //时间
    [self.contentImagView sd_setImageWithURL:model.imageUrl];
    self.headLabel.text = model.title;
    CGFloat min_h = [model.title textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:139].height;
    [self.headLabel updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(min_h);
    }];
    self.entranceLabel.text = [NSString stringWithFormat:@"入场时间:%@",model.admissionTime];
    self.startTimeLabel.text =[NSString stringWithFormat:@"开场时间:%@",model.startTime];;
    self.siteLabel.text = model.siteAddr;
    self.countLabel.text = [NSString stringWithFormat:@"(%@/%@人)",model.personSum,model.personTotal];
}

@end
