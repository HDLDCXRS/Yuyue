//
//  CommonUserView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CommonUserView.h"

@implementation CommonUserView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _bgcView = [[UIImageView alloc] init];
        _bgcView.backgroundColor = [UIColor whiteColor];
        _bgcView.layer.cornerRadius = 5.0;
        _bgcView.layer.shadowColor = [UIColor blueColor].CGColor;//阴影颜色
        _bgcView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        _bgcView.layer.shadowOpacity = 0.3;//不透明度
        _bgcView.layer.shadowRadius = 2.0;//半径
        [self addSubview:_bgcView];
        [_bgcView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(100);
        }];
        [self layoutIfNeeded];
        _scanBtn = [[UIButtonCommonView alloc] initWithFrame:CGRectZero setBtnImg:@"扫一扫" Title:@"扫一扫"];
       // [_scanBtn addTarget:self action:@selector(commonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scanBtn];
        [_scanBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcView.top).equalTo(19);
            make.left.equalTo((SCREENWIDTH-110-84)/3);
            make.size.equalTo(CGSizeMake(55, 55));
        }];
        _scanBtn.tag = 3;
      
        _mineMoneyBtn = [[UIButtonCommonView alloc] initWithFrame:CGRectZero setBtnImg:@"我的钱包" Title:@"我的钱包"];
        [self addSubview:_mineMoneyBtn];
        [_mineMoneyBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcView.top).equalTo(19);
            make.left.equalTo(self.scanBtn.right).offset((SCREENWIDTH-110-84)/3);
            make.size.equalTo(CGSizeMake(55, 55));
        }];
        _mineMoneyBtn.tag = 4;
        _mineMoneyBtn.userInteractionEnabled =YES;
    }
    return self;
}
-(void)commonClick:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}
@end
