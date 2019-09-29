//
//  Withdrawal recordTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "WithdrawalrecordTableViewCell.h"

@implementation WithdrawalrecordTableViewCell

- (UILabel *)tixinanLabel
{
    if (!_tixinanLabel) {
        _tixinanLabel = [[UILabel alloc] init];
        _tixinanLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _tixinanLabel.textColor = RGBA(37, 37, 37, 1);
        _tixinanLabel.text =@"申请提现";
    }
    return _tixinanLabel;
}
- (UILabel *)tixianMoneyLabel
{
    if (!_tixianMoneyLabel) {
        _tixianMoneyLabel = [[UILabel alloc] init];
        _tixianMoneyLabel.font = [UIFont fontWithName:@"PingFang SC" size: 18];
        _tixianMoneyLabel.textColor = RGBA(26, 151, 224, 1);
        _tixianMoneyLabel.text = @"0";
        _tixianMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tixianMoneyLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _timeLabel.textColor = RGBA(123, 123, 123, 1);
        _timeLabel.text = @"申请时间";
    }
    return _timeLabel;
}
- (UILabel *)tiXianTime
{
    if (!_tiXianTime) {
        _tiXianTime = [[UILabel alloc] init];
        _tiXianTime.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _tiXianTime.textColor = RGBA(123, 123, 123, 1);
//        _tiXianTime.text = @"2019-02-23  15:18:20";
        _tiXianTime.textAlignment = NSTextAlignmentRight;
    }
    return _tiXianTime;
}
- (UILabel *)tiStatueLabel
{
    if (!_tiStatueLabel) {
        _tiStatueLabel = [[UILabel alloc] init];
        _tiStatueLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _tiStatueLabel.textColor = RGBA(123, 123, 123, 1);
        _tiStatueLabel.text = @"申请状态";
    }
    return _tiStatueLabel;
}
- (UILabel *)StatueLabel
{
    if (!_StatueLabel) {
        _StatueLabel = [[UILabel alloc] init];
        _StatueLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _StatueLabel.textColor = RGBA(123, 123, 123, 1);
        //_StatueLabel.text  =@"提现成功";
        _StatueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _StatueLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.tixinanLabel];
    [self addSubview:self.tixianMoneyLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.tiXianTime];
    [self addSubview:self.tiStatueLabel];
    [self addSubview:self.StatueLabel];
    [self updateConstraintsForView];
    
}
- (void)updateConstraintsForView
{
    [self.tixinanLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.equalTo(15);
        make.height.equalTo(14);
        make.width.equalTo(60);
    }];
    [self.tixianMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(14);
        make.right.equalTo(-15);
        make.height.equalTo(18);
        make.left.equalTo(self.tixinanLabel.right).offset(0);
    }];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tixinanLabel.bottom).offset(15);
        make.left.equalTo(15);
        make.height.equalTo(14);
        make.width.equalTo(60);
    }];
    [self.tiXianTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.centerY);
        make.right.equalTo(-15);
        make.height.equalTo(18);
        make.left.equalTo(self.timeLabel.right).offset(0);
    }];
    [self.tiStatueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.bottom).offset(15);
        make.left.equalTo(15);
        make.height.equalTo(14);
        make.width.equalTo(60);
    }];
    [self.StatueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.bottom).offset(15);
        make.right.equalTo(-15);
        make.height.equalTo(14);
        make.left.equalTo(self.tiStatueLabel.right).offset(0);
    }];
   
}
-(void)setModel:(WithdrawalRecordModel * _Nonnull)model
{
    self.tixianMoneyLabel.text = [NSString stringWithFormat:@"%.2f",model.money];
    self.tiXianTime.text = model.completeTime;
    if ([model.status isEqualToString:@"10B"]) {
        self.StatueLabel.text = @"提现成功";
    }
    else
    {
         self.StatueLabel.text = @"提现失败";
    }
}
@end
