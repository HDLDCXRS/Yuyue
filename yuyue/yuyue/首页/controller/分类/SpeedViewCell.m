//
//  SpeedViewCell.m
//  yuYue
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "SpeedViewCell.h"

@implementation SpeedViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"话剧"];
        CGSize size = _iconImg.image.size;
        [self.contentView addSubview:_iconImg ];
        [_iconImg  makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo((SCREENWIDTH/4-size.width)/2);
            make.width.equalTo(size.width);
            make.height.equalTo(size.height);
        }];
        _iconLabel = [UILabel labelWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"哈哈哈" textColor:RGBA(16, 16, 16, 1) fontSize:25.0 textAlignment:NSTextAlignmentCenter numberOfLines:0 adjustsFontSizeToFitWidth:YES];
        _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        [self.contentView addSubview:_iconLabel];
        [_iconLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImg .bottom).offset(9);
            make.height.equalTo(20);
            make.left.equalTo(0);
            make.right.equalTo(0);
        }];
    }
    return self;
}
-(void)setModel:(SpeedModel * _Nonnull)model
{
    [_iconImg sd_setImageWithURL:model.url];
    [_iconLabel setText:model.category];
}
@end
