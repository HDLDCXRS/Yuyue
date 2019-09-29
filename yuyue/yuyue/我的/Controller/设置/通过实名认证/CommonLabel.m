//
//  CommonLabel.m
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CommonLabel.h"
#import "NSString+Size.h"
@implementation CommonLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
        _nameLabel.textColor = RGBA(51, 51, 51, 1);
        [self addSubview:_nameLabel];
        [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(17);
            make.left.equalTo(16);
            make.height.equalTo(16);
            make.width.equalTo(80);
        }];
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _rightLabel.textColor = RGBA(153, 153, 153, 1);
        CGFloat min_w = [_rightLabel.text textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:SCREENWIDTH-95].width;
        [self addSubview:_rightLabel];
        [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.centerY);
            make.right.equalTo(-17);
            make.height.equalTo(13);
            make.width.equalTo(min_w);
        }];
        
    }
    return self;
}
@end
