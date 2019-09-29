//
//  BaseView.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor whiteColor];
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"头像"];
        [self addSubview:_headImageView];
        [_headImageView  makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(55);
            make.centerX.equalTo(self.centerX);
            make.width.height.equalTo(78);
        }];
        _photoBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"照相机"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = _photoBtn.currentBackgroundImage.size;
        [self addSubview:_photoBtn];
        [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImageView.bottom).offset(0);
            make.right.equalTo(self.headImageView.right).offset(-11);
            make.width.height.equalTo(size.width);
        }];
    }
    return self;
}
@end
