//
//  GiftTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel  *titleLabel;  //id名称
@property(nonatomic,strong) UILabel  *timeLabel;   //时间
@property(nonatomic,strong) UILabel  *getMoneyLabel ; //收益
@end

NS_ASSUME_NONNULL_END
