//
//  FocusCollectionCell.m
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FocusCollectionCell.h"

@implementation FocusCollectionCell
- (UIImageView *)pictureImageView
{
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.image = [UIImage imageNamed:@"图层 1"];
    }
    return _pictureImageView;
}
//- (UILabel *)titleLabel
//{
//    if (!_titleLabel ) {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
//        _titleLabel.text = @"周杰伦音乐全集,在线收听稻香...";
//        _titleLabel.textColor = RGBA(255, 255, 255, 1);
//        _titleLabel.numberOfLines = 0;
//    }
//    return _titleLabel;
//}
- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"头像"];
    }
    return _iconImage;
}

- (UILabel *)iconLabel
{
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textColor = RGBA(102, 102, 102, 1);
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _iconLabel.text = @"小阳光";
    }
    return _iconLabel;
}
- (UIButton *)stateBtn
{
    if (!_stateBtn) {
        _stateBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:RGBA(225, 225, 225, 1) setTitle:@"已关注" setTitleColor:RGBA(102,102,102, 1) state:UIControlStateNormal addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _stateBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 9];
        _stateBtn.layer.masksToBounds = YES;
        _stateBtn.layer.cornerRadius = 5.0;
    }
    return _stateBtn;
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
    [self addSubview:self.pictureImageView];
  //  [self addSubview:self.titleLabel];
    [self addSubview:self.iconImage];
    [self addSubview:self.iconLabel];
    [self addSubview:self.stateBtn];
    [self updateConstraintsForView];
}
- (void)updateConstraintsForView
{
    [self.pictureImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(214);
    }];
//    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.pictureImageView.top).offset(12);
//        make.left.equalTo(self.pictureImageView.left).offset(5);
//        make.right.equalTo(self.pictureImageView.right).offset(-5);
//        make.height.equalTo(80);
//    }];
    [self.iconImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.bottom).offset(4);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(19, 19));
    }];
    [self.iconLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImage.centerY);
        make.left.equalTo(self.iconImage.right).offset(5);
        make.size.equalTo(CGSizeMake(120, 12));
    }];
    [self.stateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.bottom).offset(4);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(50, 16));
    }];
}
-(void)setModel:(FocusModel * _Nonnull)model
{
//    @property(nonatomic,strong) UIImageView  *pictureImageView;
//    @property(nonatomic,strong) UILabel  * titleLabel;
//    @property(nonatomic,strong) UIImageView  *iconImage;
//    @property(nonatomic,strong) UILabel  *iconLabel;
//    @property(nonatomic,strong) UIButton  *stateBtn;
    [_pictureImageView sd_setImageWithURL:model.frontCover];
    [_iconImage sd_setImageWithURL:model.headpUrl];
    _iconLabel.text = model.nickName;
    if([model.userStatus isEqualToString:@"10B"])
    {
        return ;
    }
    else
    {
        [_stateBtn setBackgroundColor:RGBA(26, 151, 224, 1)];
    }
    
}
@end
