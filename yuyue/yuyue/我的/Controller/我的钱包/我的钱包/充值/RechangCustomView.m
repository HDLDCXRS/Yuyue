//
//  RechangCustomView.m
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RechangCustomView.h"
@implementation RechangCustomView
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = RGBA(51, 51, 51, 1);
    }
    return _titleLabel;
}
- (UILabel *)smallLabel
{
    if (!_smallLabel) {
        _smallLabel = [[UILabel alloc] init];
        _smallLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _smallLabel.textColor = RGBA(153,153,153, 1);
    }
    return _smallLabel;
}
- (RechangCommonBtn *)combtnOne
{
    if (!_combtnOne) {
        _combtnOne = [[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"12" MoneyCount:@"8.4"];
        self.combtnOne.tag = 1;
        _combtnOne.layer.masksToBounds = YES;
        _combtnOne.layer.cornerRadius = 5.0;
    }
    return _combtnOne;
}
- (RechangCommonBtn *)combtnTwo
{
    if (!_combtnTwo) {
        _combtnTwo = [[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"30" MoneyCount:@"21"];
         self.combtnTwo.tag = 2;
        _combtnTwo.layer.masksToBounds = YES;
        _combtnTwo.layer.cornerRadius = 5.0;
    }
    return _combtnTwo;
}
- (RechangCommonBtn *)combtnThree
{
    if (!_combtnThree) {
        _combtnThree = [[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"50" MoneyCount:@"35"];
        self.combtnThree.tag = 3;
        _combtnThree.layer.masksToBounds = YES;
        _combtnThree.layer.cornerRadius = 5.0;
    }
    return _combtnThree;
}
- (RechangCommonBtn *)combtnFour
{
    if (!_combtnFour) {
        _combtnFour = [[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"128" MoneyCount:@"89.6"];
        self.combtnFour.tag = 4;
        _combtnFour.layer.masksToBounds = YES;
        _combtnFour.layer.cornerRadius = 5.0;
    }
    return _combtnFour;
}
- (RechangCommonBtn *)combtnFive
{
    if (!_combtnFive) {
        _combtnFive = [[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"618" MoneyCount:@"432.6"];
        _combtnFive.layer.masksToBounds = YES;
        _combtnFive.layer.cornerRadius = 5.0;
        self.combtnFive.tag = 5;
    }
    return _combtnFive;
}
- (RechangCommonBtn *)combtnSix
{
    if (!_combtnSix) {
        _combtnSix =[[RechangCommonBtn alloc] initWithFrame:CGRectZero ZSCount:@"6498" MoneyCount:@"4548.6"];
        _combtnSix.layer.masksToBounds = YES;
        _combtnSix.layer.cornerRadius = 5.0;
        self.combtnSix.tag = 6;
    }
    return _combtnSix;
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
    [self.combtnOne addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.combtnTwo addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.combtnThree addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.combtnFour addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.combtnFive addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.combtnSix addTarget:self action:@selector(onClickMethod:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:self.titleLabel];
     [self addSubview:self.smallLabel];
     [self addSubview:self.combtnOne];
     [self addSubview:self.combtnTwo];
     [self addSubview:self.combtnThree];
     [self addSubview:self.combtnFour];
     [self addSubview:self.combtnFive];
     [self addSubview:self.combtnSix];
    [self updateConstraintsForView];
    
   
}
-(void)updateConstraintsForView
{
    CGFloat min_w = [_titleLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 15] limitWidth:SCREENHEIGHT/2].width;
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(19);
        make.left.equalTo(19);
        make.width.equalTo(min_w);
        make.height.equalTo(14);
    }];
    [self.smallLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.left.equalTo(self.titleLabel.left).offset(9);
        make.right.equalTo(0);
        make.height.equalTo(12);
    }];
    [self.combtnOne makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(19);
        make.left.equalTo(19);
        make.size.equalTo(CGSizeMake((SCREENWIDTH-51)/2, 40));
    }];
    [self.combtnTwo makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.combtnOne.centerY);
        make.left.equalTo(self.combtnOne.right).offset(13);
        make.right.equalTo(-19);
        make.height.equalTo(40);
    }];
    [self.combtnThree makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.combtnOne.bottom).offset(17);
        make.left.equalTo(19);
        make.left.equalTo(19);
        make.size.equalTo(CGSizeMake((SCREENWIDTH-51)/2, 40));
    }];
    [self.combtnFour makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.combtnThree.centerY);
        make.left.equalTo(self.combtnThree.right).offset(13);
        make.right.equalTo(-19);
        make.height.equalTo(40);
    }];
    [self.combtnFive makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.combtnThree.bottom).offset(17);
        make.left.equalTo(19);
        make.left.equalTo(19);
        make.size.equalTo(CGSizeMake((SCREENWIDTH-51)/2, 40));
    }];
    [self.combtnSix makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.combtnFive.centerY);
        make.left.equalTo(self.combtnFive.right).offset(13);
        make.right.equalTo(-19);
        make.height.equalTo(40);
    }];
}
-(void)onClickMethod:(RechangCommonBtn* )btn
{
    if (_clickBlock) {
        _clickBlock(btn);
    }
}
@end
