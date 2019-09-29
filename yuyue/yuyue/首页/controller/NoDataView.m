//
//  NoDataView.m
//  yuyue
//
//  Created by edz on 2019/9/24.
//  Copyright © 2019 edz. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _noDataImageView = [[UIImageView alloc] init];
        _noDataImageView.image = [UIImage imageNamed:@"暂无"];
        CGSize size = _noDataImageView.image.size;
        [self addSubview:_noDataImageView];
        [_noDataImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(67);
            make.centerX.equalTo(self.centerX);
            make.size.equalTo(CGSizeMake(size.width,size.height));
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = RGBA(102, 102, 102, 1);
        _titleLabel.text = @"暂 无 数 据";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.noDataImageView.centerX);
            make.top.equalTo(self.noDataImageView.bottom).offset(17);
            make.size.equalTo(CGSizeMake(SCREENHEIGHT, 14));
        }];
    }
    return self;
}
@end
