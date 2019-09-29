//
//  RechangCommonBtn.m
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RechangCommonBtn.h"

@implementation RechangCommonBtn
- (instancetype)initWithFrame:(CGRect)frame  ZSCount:(NSString*)count MoneyCount:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        _pictureImg = [[UIImageView alloc] init];
        _pictureImg.image = [UIImage imageNamed:@"钻石"];
        CGSize size = _pictureImg.image.size;
        [self addSubview:_pictureImg];
        [_pictureImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(11);
            make.left.equalTo(9);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        _countZSLabel = [[UILabel alloc] init];
        _countZSLabel.font = [UIFont fontWithName:@"PingFang SC" size: 18];
        _countZSLabel.textColor = RGBA(51, 51, 51, 1);
        _countZSLabel.text = count;
        size = [_countZSLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 18] limitWidth:30];
        [self addSubview:_countZSLabel];
        [_countZSLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pictureImg.right).offset(8);
            make.centerY.equalTo(self.pictureImg.centerY);
            make.size.equalTo(CGSizeMake(80, size.height));
        }];
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _moneyLabel.textColor = RGBA(102, 102, 102, 1);
        _moneyLabel.text = text;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
//        size = [_moneyLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:35];
        [self addSubview:_moneyLabel];
        [_moneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.countZSLabel.centerY);
            make.right.equalTo(-11);
            make.height.equalTo(11);
            make.width.equalTo(80);
        }];
    }
    return self;
}
@end
