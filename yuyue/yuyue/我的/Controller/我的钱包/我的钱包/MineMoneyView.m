//
//  MineMoneyView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineMoneyView.h"

@implementation MineMoneyView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lastMoneyView = [[MineCommonMoneyView alloc] initWithFrame:CGRectZero setHeadTitle:@"我的余额" setBgcView:@"紫色背景" setIconView:@"钻石" setTiTle:@"钻石币" setContentLabel:@"用于礼物购买" setBtn:@"充值" setBtnColor:RGBA(153, 132, 251, 1)];
        [self addSubview:_lastMoneyView];
        [_lastMoneyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(21);
            make.left.right.equalTo(0);
            make.height.equalTo(110);
        }];
        _getMoneyView = [[MineCommonMoneyView alloc] initWithFrame:CGRectZero setHeadTitle:@"我的收入" setBgcView:@"粉色背景" setIconView:@"收入" setTiTle:@"我的收益" setContentLabel:@"您的收益可提现" setBtn:@"提现" setBtnColor:RGBA(251, 63, 134, 1)];
        [self addSubview:_getMoneyView];
        [_getMoneyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lastMoneyView.bottom).offset(40);
            make.left.right.equalTo(0);
            make.height.equalTo(110);
        }];
        
    }
    return self;
}
-(void)setModel:(LoginModel * _Nonnull)model
{
    _lastMoneyView.countLabel.text =[NSString stringWithFormat:@"%.2f", model.total];
    _getMoneyView.countLabel.text = [NSString stringWithFormat:@"%.2f", model.income] ;
  

}
@end
