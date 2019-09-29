//
//  GiftTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import "GiftTableViewCell.h"

@implementation GiftTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
        _titleLabel.textColor = RGBA(51, 51, 51, 1);
        _titleLabel.text = @"肖天阳";
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(19);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake((SCREENWIDTH-30)/2, 14));
        }];
    
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _timeLabel.textColor = RGBA(102, 102, 102, 1);
        _timeLabel.text = @"2019.03.03  14:22";
        [self addSubview:_timeLabel];
        [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(10);
            make.left.equalTo(15);
            make.right.equalTo(0);
            make.height.equalTo(10);
        }];
        _getMoneyLabel = [[UILabel alloc] init];
        _getMoneyLabel.textAlignment = NSTextAlignmentRight;
        _getMoneyLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _getMoneyLabel.textColor = RGBA(51, 51, 51, 1);
        _getMoneyLabel.text =@"+44";
        [self addSubview:_getMoneyLabel];
        [_getMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(19);
            make.right.equalTo(-15);
            make.size.equalTo(CGSizeMake((SCREENWIDTH-30)/2, 14));
        }];
    }
    return self;
}
@end
