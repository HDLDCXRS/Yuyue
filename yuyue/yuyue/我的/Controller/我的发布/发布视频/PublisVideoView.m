//
//  PublisVideoView.m
//  yuyue
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PublisVideoView.h"

@implementation PublisVideoView
-(UIImageView*)bgcImgView
{
    if (!_bgcImgView) {
        _bgcImgView = [[UIImageView alloc] init];
        _bgcImgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgcImgView;
}
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn =[UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"发布视频"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(selectMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
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
    [self addSubview:self.bgcImgView];
    [self addSubview:self.selectBtn];
    [self updateConstraintsForView];
}
//添加约束
-(void)updateConstraintsForView
{
    [self.bgcImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(212);
    }];
    CGSize size = _selectBtn.currentBackgroundImage.size;
    [_selectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgcImgView.top).offset(28);
        make.left.equalTo(15);
        make.width.height.equalTo(size.width);
    }];
}
-(void)selectMethod:(UIButton*)btn
{
    if (_onClickBtn) {
        _onClickBtn(btn);
    }
}
@end
