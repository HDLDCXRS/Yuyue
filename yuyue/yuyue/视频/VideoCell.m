//
//  VideoCell.m
//  yuyue
//
//  Created by edz on 2019/10/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
@implementation VideoCell
//@property(nonatomic,strong) UIImageView  *bgcImageView; //背景图
//@property(nonatomic,strong) UILabel  *titleLabel; //标题
//@property(nonatomic,strong) UIImageView  *iconImage; //头像
//@property(nonatomic,strong) UILabel  *iconLabel;  //头像名字
//@property(nonatomic,strong) UILabel  *commentLabel; // 评论名字
//@property(nonatomic,strong) UILabel  *likeLabel;  //关注
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bgcImageView = [[UIImageView alloc] init];
        _bgcImageView.image = [UIImage imageNamed:@"图层0"];
        CGSize size = _bgcImageView.image.size;
        [self addSubview:_bgcImageView];
        [_bgcImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(size.height);
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text =@"金星跳舞多厉害，一段舞蹈惊艳全场，足以让你爱上她!";
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcImageView.top).offset(5);
            make.left.equalTo(self.bgcImageView.left).offset(5);
            make.right.equalTo(self.bgcImageView.right).offset(-5);
            make.height.equalTo(60);
        }];
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"头像"];
        size = _iconImage.image.size;
        [self addSubview:_iconImage];
        [_iconImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcImageView.bottom).offset(5);
            make.left.equalTo(15);
            make.width.equalTo(19);
            make.height.equalTo(19);
        }];
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _iconLabel.text = @"hahh";
        [self addSubview:_iconLabel];
        [_iconLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.centerY);
            make.left.equalTo(self.iconImage.right).offset(2);
            make.width.equalTo(90);
            make.height.equalTo(13);
        }];
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _likeLabel.textColor = RGBA(153, 153, 153, 1);
        _likeLabel.textAlignment = NSTextAlignmentRight;
        _likeLabel.text = @"0关注";
        [self addSubview:_likeLabel];
        [_likeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.centerY);
            make.right.equalTo(-15);
            make.width.equalTo(45);
            make.height.equalTo(12);
        }];
        //
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _commentLabel.textColor = RGBA(153, 153, 153, 1);
        _commentLabel.text = @"0评论";
        _commentLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_commentLabel];
        [_commentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.likeLabel.centerY);
            make.right.equalTo(self.likeLabel.left).equalTo(-17);
            make.height.equalTo(13);
            make.width.equalTo(80);
        }];
    }
    return self;
}
- (void)setBgcModel:(VideoModel *)bgcModel
{
    [_bgcImageView sd_setImageWithURL:bgcModel.videoAddress];
    [_iconImage sd_setImageWithURL:bgcModel.appUser.headpUrl];
    _iconLabel.text = bgcModel.appUser.nickName;
    _commentLabel.text = [NSString stringWithFormat:@"%@评论",bgcModel.appUser.attentionTotal];
    _likeLabel.text =  [NSString stringWithFormat:@"%@关注",bgcModel.appUser.likeTotal];
    _titleLabel.text = bgcModel.title;
}
@end
