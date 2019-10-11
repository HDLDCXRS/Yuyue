//
//  CommentTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CommentTableViewCell.h"
//@property(nonatomic,strong) UIImageView  *iconImage;
//@property(nonatomic,strong) UILabel  *iconLabel;
//@property(nonatomic,strong) UILabel  *timeLabel;
//@property(nonatomic,strong) UILabel  *contentLabel;
@implementation CommentTableViewCell
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
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _iconLabel.text = @"暖暖的春风";
        _iconLabel.textColor = RGBA(102, 102, 102, 1);
    }
    return _iconLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _timeLabel.text = @"3分钟前";
        _timeLabel.textColor =  RGBA(102, 102, 102, 1);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = RGBA(51, 51, 51, 1);
        _contentLabel.text = @"啊哈哈哈哈哈";
        _contentLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
    }
    return _contentLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    [self addSubview:self.iconLabel];
    [self addSubview:self.iconImage];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self updateConstraintsForView];
}
- (void)updateConstraintsForView
{
    [self.iconImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(15);
        make.size.equalTo(CGSizeMake(28, 28));
    }];
    [self.iconLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.left.equalTo(self.iconImage.right).offset(8);
        make.width.equalTo(100);
        make.height.equalTo(11);
    }];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconLabel.bottom).offset(9);
        make.left.equalTo(self.iconImage.right).offset(8);
        make.right.equalTo(0);
        make.height.equalTo(13);
    }];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.right.equalTo(-15);
        make.height.equalTo(11);
        make.left.equalTo(self.iconLabel.right).offset(0);
    }];
}
@end
