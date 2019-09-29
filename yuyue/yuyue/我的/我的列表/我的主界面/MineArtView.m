//
//  MineArtView.m
//  yuYue
//
//  Created by edz on 2019/8/20.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineArtView.h"
#define  distance   SCREENWIDTH/9
@implementation MineArtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fansTitle = [[UILabel alloc] init];
        _fansTitle.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _fansTitle.textColor = RGBA(255, 255, 255, 1);
        _fansTitle.text = @"粉丝";
        _fansTitle.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_fansTitle];
        [_fansTitle makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(distance);
            make.width.equalTo(distance);
            make.height.equalTo(13);
        }];
        _fansCount = [[UILabel alloc] init];
        _fansCount.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _fansCount.textColor=RGBA(255, 255, 255, 1);
         _fansCount.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_fansCount];
        _fansCount.text = @"0";
        [_fansCount makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.fansTitle.top).offset(-10);
            make.centerX.equalTo(self.fansTitle.centerX);
            make.height.equalTo(10);
            make.width.equalTo(distance);
        }];
        //点赞
        _clickTitle = [[UILabel alloc] init];
        _clickTitle.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _clickTitle.textColor = RGBA(255, 255, 255, 1);
        _clickTitle.text = @"点赞";
        _clickTitle.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_clickTitle];
        [_clickTitle makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(self.fansTitle.right).offset(distance);
            make.width.equalTo(distance);
            make.height.equalTo(13);
        }];
        _clickCount = [[UILabel alloc] init];
        _clickCount.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _clickCount.textColor=RGBA(255, 255, 255, 1);
        _clickCount.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_clickCount];
        _clickCount.text = @"0";
        [_clickCount makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.fansTitle.top).offset(-10);
            make.centerX.equalTo(self.clickTitle.centerX);
            make.height.equalTo(10);
            make.width.equalTo(distance);
        }];
     //评论
        _commentsTitle = [[UILabel alloc] init];
        _commentsTitle.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _commentsTitle.textColor = RGBA(255, 255, 255, 1);
        _commentsTitle.text = @"评论";
        _commentsTitle.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_commentsTitle];
        [_commentsTitle makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(self.clickTitle.right).offset(distance);
            make.width.equalTo(distance);
            make.height.equalTo(13);
        }];
        _commentCount = [[UILabel alloc] init];
        _commentCount.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _commentCount.textColor=RGBA(255, 255, 255, 1);
        _commentCount.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_commentCount];
        _commentCount.text = @"0";
        [_commentCount makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.fansTitle.top).offset(-10);
            make.centerX.equalTo(self.commentsTitle.centerX);
            make.height.equalTo(10);
            make.width.equalTo(distance);
        }];
       //收益
        _earningBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:nil setTitle:@"礼物" setTitleColor:[UIColor whiteColor] state:UIControlStateNormal addTarget:self action:@selector(onClickEarn:) forControlEvents:UIControlEventTouchUpInside];

        _earningBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _earningBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        [self addSubview:_earningBtn];
        [_earningBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(self.commentsTitle.right).offset(distance);
            make.width.equalTo(distance);
            make.height.equalTo(13);
        }];
        _earningCount = [[UILabel alloc] init];
        _earningCount.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _earningCount.textColor=RGBA(255, 255, 255, 1);
        _earningCount.textAlignment =NSTextAlignmentCenter;
        _earningCount.text = @"0";
        [self addSubview:_earningCount];
        [_earningCount makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.fansTitle.top).offset(-10);
            make.centerX.equalTo(self.earningBtn.centerX);
            make.height.equalTo(10);
            make.width.equalTo(distance);
        }];
    }
    return self;
}
-(void)onClickEarn:(UIButton *)btn
{
    if (_clickBtn) {
        _clickBtn(btn);
    }
}

@end
