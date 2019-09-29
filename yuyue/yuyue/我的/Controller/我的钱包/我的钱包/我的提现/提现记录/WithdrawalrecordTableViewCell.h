//
//  Withdrawal recordTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawalRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalrecordTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel  *tixinanLabel; //提现申请
@property(nonatomic,strong) UILabel  *tixianMoneyLabel; //提现时间
@property(nonatomic,strong) UILabel  *timeLabel;  //申请时间
@property(nonatomic,strong) UILabel *tiXianTime; // 提现时间
@property(nonatomic,strong) UILabel  *tiStatueLabel; //提现状态
@property(nonatomic,strong) UILabel  *StatueLabel; //提现成功
@property(nonatomic,strong) WithdrawalRecordModel  *model;
-(void)setModel:(WithdrawalRecordModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
