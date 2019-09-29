//
//  DiverSceneViewTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DiverSceneViewTableViewCell.h"
#import "NSString+Size.h"
#import <UIImageView+AFNetworking.h>
@implementation DiverSceneViewTableViewCell


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
-(UIImageView*)loactionView
{
    if (!_loactionView) {
        _loactionView = [[UIImageView alloc ] init];
        _loactionView.image = [UIImage imageNamed:@"定位 (1)"];
    }
    return _loactionView;
}
-(UILabel*)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _locationLabel.textColor = RGBA(102, 102, 102, 1);
    }
    return _locationLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _countLabel.text = @"(20/50人)";
        _countLabel.textColor = RGBA(102, 102, 102, 1);
    }
    return _countLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _timeLabel.textColor = RGBA(153, 153, 153, 1);
        _timeLabel.text = @"2010年3月2日";
    }
    return _timeLabel;
}
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
    [self addSubview:self.locationLabel];
    [self addSubview:self.loactionView];
    [self addSubview:self.timeLabel];
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
    CGSize size = _loactionView.image.size;
    [self.loactionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImagView.bottom).offset(8);
           make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(size.width,size.height));
    }];
    CGFloat min_w = [_locationLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:139].width;
    [self.locationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loactionView.right).offset(5);
        make.centerY.equalTo(self.loactionView.centerY);
        make.width.equalTo(115);
        make.height.equalTo(13);
    }];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationLabel.centerY);
        make.left.equalTo(self.locationLabel.right).offset(7);
        make.width.equalTo(140);
        make.height.equalTo(13);
    }];
    min_w  = [_timeLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 11] limitWidth:SCREENWIDTH].width;
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countLabel.centerY);
        make.right.equalTo(self.contentImagView.right).offset(0);
        make.width.equalTo(90);
        make.height.equalTo(11);
    }];
}
-(void)setModel:(DiverSceneModel *)model
{
    
//    @property(nonatomic,strong) UILabel  *headLabel;
//    @property(nonatomic,strong) UIImageView  *contentImagView;
//    @property(nonatomic,strong) UIImageView  *loactionView; //
//    @property(nonatomic,strong) UILabel  *locationLabel; //位置信息
//    @property(nonatomic,strong) UILabel* countLabel;  //共有多少人
//    @property(nonatomic,strong) UILabel  *timeLabel;  //时间
    self.headLabel.text = model.title;
     CGFloat min_h = [model.title textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:139].height;
    [_headLabel updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(min_h);
    }];
    [self.contentImagView setImageWithURL:model.imageUrl];
    NSString *dateStr= model.startTime;
    NSDateFormatter *nextformatter = [[NSDateFormatter alloc] init] ;
    [nextformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[nextformatter dateFromString:dateStr];
    [nextformatter setDateFormat:@"yyyy"];
    NSInteger year=[[nextformatter stringFromDate:date] integerValue];
    [nextformatter setDateFormat:@"MM"];
    NSInteger month=[[nextformatter stringFromDate:date]integerValue];
    [nextformatter setDateFormat:@"dd"];
    NSInteger day=[[nextformatter stringFromDate:date] integerValue];
    self.timeLabel.text =[NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
    self.locationLabel.text = model.siteAddr;
    
    self.countLabel.text = [NSString stringWithFormat:@"(%@/%@人)",model.personSum,model.personTotal];
}
@end
