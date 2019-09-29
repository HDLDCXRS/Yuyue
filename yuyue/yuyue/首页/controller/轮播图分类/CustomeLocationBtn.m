//
//  CustomeLocationBtn.m
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CustomeLocationBtn.h"

@implementation CustomeLocationBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _locationImage = [[UIImageView alloc] init];
        _locationImage.image = [UIImage imageNamed:@"定位 (1)"];
        [self addSubview:_locationImage];
        CGSize  btnImageSize = _locationImage.image.size;
        [ _locationImage makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(15);
            make.width.equalTo(btnImageSize.width);
            make.height.equalTo(btnImageSize.height);
        }];
        _loactionLabel = [[UILabel alloc] init];
        _loactionLabel.numberOfLines = 0;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"杭州" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15],NSForegroundColorAttributeName:RGBA(37, 37, 37, 1)}];
        _loactionLabel.attributedText = string;
        [self addSubview:_loactionLabel];
        [_loactionLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(self.locationImage.right).offset(5);
            make.height.equalTo(btnImageSize.height);
            make.right.equalTo(0);
        }];
    }
    return self;
}

@end
