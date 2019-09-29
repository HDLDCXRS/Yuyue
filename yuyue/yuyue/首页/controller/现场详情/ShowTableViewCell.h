//
//  ShowTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShowTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel   *rightLabel;
@property(nonatomic,strong) UILabel   *minLabel;
@property(nonatomic,strong) UILabel   *leftLabel;
@property(nonatomic,strong) ShowModel  *model;
-(void)setModel:(ShowModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
