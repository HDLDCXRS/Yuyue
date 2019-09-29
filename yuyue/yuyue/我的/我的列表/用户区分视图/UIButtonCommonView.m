//
//  UIButtonCommonView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "UIButtonCommonView.h"

@implementation UIButtonCommonView
- (instancetype)initWithFrame:(CGRect)frame setBtnImg:(NSString *)str  Title:(NSString *)strA
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconBtn = [[UIImageView alloc]init] ;
        _iconBtn.image = [UIImage imageNamed:str];
        CGSize size = _iconBtn.image.size;
        [self addSubview:_iconBtn];
        [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _contentLabel.textColor = RGBA(41, 43, 50, 1);
        _contentLabel.text = strA;
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconBtn.bottom).offset(10);
            make.centerX.equalTo(self.iconBtn.centerX);
            make.height.equalTo(13);
        }];
        
        
    }
    return self;
}
@end
