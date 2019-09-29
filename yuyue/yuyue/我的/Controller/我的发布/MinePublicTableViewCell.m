//
//  MinePublicTableViewCell.m
//  yuYue
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MinePublicTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MinePublicTableViewCell
- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.layer.cornerRadius = 22;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.image = [UIImage imageNamed:@"头像"];
    }
    return _headImgView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 14];
        _titleLabel.text = @"她们都叫我";
        _titleLabel.textColor =RGBA(51, 51, 51, 1);
    }
    return _titleLabel;
}
-(UILabel*)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont fontWithName:@"PingFang SC" size: 11];
        
    }
    return _stateLabel;
}
-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 12];
        _timeLabel.text = @"13:32";
        _timeLabel.textColor =RGBA(153, 153, 153, 1);
    }
    return _timeLabel;
}
//内容
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = RGBA(51, 51, 51, 1);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
//线
-(UIImageView*)lineImg
{
    if (!_lineImg) {
        _lineImg = [[UIImageView alloc] init];
        _lineImg.backgroundColor = RGBA(230, 230, 230, 1);
    }
    return _lineImg;
}
-(UIImageView*)contenImage
{
    if (!_contenImage) {
        _contenImage = [[UIImageView alloc] init];
       // _contenImage.contentMode = UIViewContentModeCenter;
        self.contenImage.image = [UIImage imageNamed:@"发布展位图"];
    }
    return _contenImage;
}
#pragma mark -初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.stateLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineImg];
    [self.contentView addSubview:self.contenImage];
    [self updateConstraintsForView];
}

#pragma mark -布局
- (void)updateConstraintsForView
{
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(16);
        make.top.equalTo(self.contentView.top).offset(13);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    [_stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(16);
        make.right.equalTo(-16);
        make.size.equalTo(CGSizeMake(38, 17));
    }];
    //用户ID
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(19);
        make.left.equalTo(self.headImgView.right).offset(11);
        make.height.equalTo(13);
        make.right.equalTo(self.stateLabel.left).offset(0);
    }];
    //时间
    [_timeLabel  makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(10);
        make.left.equalTo(self.headImgView.right).offset(11);
        make.right.equalTo(0);
        make.height.equalTo(10);
    }];
   
    //线
    [_lineImg makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.bottom).offset(0);
        make.height.equalTo(1);
        make.left.right.equalTo(0);
    }];
    [_contenImage makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineImg.top).offset(-20);
        make.left.equalTo(16);

        make.size.equalTo(CGSizeMake(SCREENWIDTH-32, 141));
    }];
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.bottom).offset(21);
        make.left.equalTo(14);
        make.right.equalTo(-14);
        make.bottom.equalTo(self.lineImg.top).offset(-173);
    }];
}
- (void)setModel:(MinePublishModel *)model
{
    [_headImgView setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"headpUrl"]]];
    if([model.status isEqualToString:@"10A"])
    {
        //等待处理
        _stateLabel.textColor = RGBA(173,173,173,1);
        _stateLabel.text = @"审核中";
    }
    else if([model.status isEqualToString:@"10B"])
    {
        //处理成功
        _stateLabel.textColor = RGBA(26, 151, 224, 1);
        _stateLabel.text = @"已通过";
    }
    else
    {
        _stateLabel.textColor = RGBA(223, 34,34, 1);
        _stateLabel.text = @"未通过";
    }
    [_contenImage setImageWithURL:model.videoAddress];
    _timeLabel.text = model.uploadTime;
    _titleLabel.text = model.title;
    _nameLabel.text = model.desc;
}
@end
