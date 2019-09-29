//
//  VideoTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/4.
//  Copyright © 2019 edz. All rights reserved.
//

#import "VideoTableViewCell.h"
#import <ZFPlayer/UIImageView+ZFCache.h>
@interface VideoTableViewCell()
@property (nonatomic, strong) UIImageView *headImageView; //头像
@property (nonatomic, strong) UILabel *nickNameLabel;  //id
@property (nonatomic, strong) UIImageView *coverImageView; //第一帧图片
@property (nonatomic, strong) UIView *fullMaskView;  //
@property (nonatomic, strong) UIButton *playBtn;  //播放按钮
@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic,weak) id  <VideoTableViewCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIView *effectView;
@end
@implementation VideoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.effectView];
        [self.contentView addSubview:self.coverImageView];
        [self.coverImageView addSubview:self.playBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.fullMaskView];
        self.contentView.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setLayout:(HDLTableViewCellLayout *)layout
{
    _layout = layout;
    _layout = layout;
    self.headImageView.frame = layout.headerRect; //头像
    self.nickNameLabel.frame = layout.nickNameRect; //头像名
    self.coverImageView.frame = layout.videoRect; // 封面的大小
    self.bgImgView.frame = layout.videoRect;  //背景图
    self.effectView.frame = self.bgImgView.bounds;
    self.titleLabel.frame = layout.titleLabelRect;
    self.playBtn.frame = layout.playBtnRect;
    self.fullMaskView.frame = layout.maskViewRect;
    [self.headImageView setImageWithURLString:layout.data.head placeholder:[UIImage imageNamed:@"defaultUserIcon"]]; //默认头像
    [self.coverImageView setImageWithURLString:layout.data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];  //封面图
    [self.bgImgView setImageWithURLString:layout.data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];  //背景图
    self.nickNameLabel.text = layout.data.nick_name; //名字
    self.titleLabel.text = layout.data.title; //下方文字
}
- (void)setDelegate:(id<VideoTableViewCellDelegate>)delegate withIndexPath:(NSIndexPath *)indexPath {
    self.delegate = delegate;
    self.indexPath = indexPath;
}
//正常情况下
- (void)setNormalMode {
    self.titleLabel.hidden = NO;
    self.fullMaskView.hidden =  YES;
    self.titleLabel.textColor = [UIColor whiteColor]; //下方文字
    self.nickNameLabel.textColor = [UIColor blackColor]; //
    self.contentView.backgroundColor = [UIColor whiteColor];
}
//展示的时候
- (void)showMaskView {

    [UIView animateWithDuration:0.3 animations:^{
        self.fullMaskView.alpha = 0;
    }];
}
//隐藏动画
- (void)hideMaskView {

    [UIView animateWithDuration:0.3 animations:^{
        self.fullMaskView.alpha = 1;
    }];
}

- (void)playBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(hdl_playTheVideoAtIndexPath:)]) {
        [self.delegate hdl_playTheVideoAtIndexPath:self.indexPath];
        
    }
    
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIView *)fullMaskView {
    if (!_fullMaskView) {
        _fullMaskView = [UIView new];
        _fullMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _fullMaskView.userInteractionEnabled = NO;
    }
    return _fullMaskView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    }
    return _titleLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nickNameLabel;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
     
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = 100;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}
//毛玻璃效果
- (UIView *)effectView {
    if (!_effectView) {
        if (@available(iOS 8.0, *)) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        } else {
            UIToolbar *effectView = [[UIToolbar alloc] init];
            effectView.barStyle = UIBarStyleBlackTranslucent;
            _effectView = effectView;
        }
    }
    return _effectView;
}

@end
