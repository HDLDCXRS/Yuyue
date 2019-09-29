//
//  PassRealNameView.m
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PassRealNameView.h"

@implementation PassRealNameView
- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"你已通过实名认证"];
        CGSize size = imgView.image.size;
        [self addSubview:imgView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.right.equalTo(0);
            make.height.equalTo(size.height);
        }];
        _comonLabel_one = [[CommonLabel alloc] init];
        _comonLabel_one.nameLabel.text = @"真实姓名";
        [self addSubview:_comonLabel_one];
        [_comonLabel_one makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.bottom).offset(0);
            make.left.right.equalTo(0);
            make.height.equalTo(47);
        }];
        _comonLabel_tw0 = [[CommonLabel alloc] init];
        _comonLabel_tw0.nameLabel.text = @"身份证号";
        [self addSubview:_comonLabel_tw0];
        [_comonLabel_tw0 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.comonLabel_one.bottom).offset(0);
            make.left.right.equalTo(0);
            make.height.equalTo(47);
        }];
        _comonLabel_three = [[CommonLabel alloc] init];
        _comonLabel_three.nameLabel.text = @"证件审核";
        [self addSubview:_comonLabel_three];
        [_comonLabel_three makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.comonLabel_tw0.bottom).offset(10);
            make.left.right.equalTo(0);
            make.height.equalTo(47);
        }];
        self.backgroundColor= RGBA(243, 243, 243, 1);
    }
    return self;
}

@end
