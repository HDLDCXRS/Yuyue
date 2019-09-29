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
    _photoBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"头像"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(pickPhoto:) forControlEvents:UIControlEventTouchUpInside];
  
    [self addSubview:_photoBtn];
    [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(55);
            make.centerX.equalTo(self.centerX);
            make.width.height.equalTo(78);
    }];
    _headImageView = [[UIImageView alloc] init];
    _headImageView.image = [UIImage imageNamed:@"照相机"];
    CGSize size = _headImageView.image.size;
    [self addSubview:_headImageView];
    [_headImageView  makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.photoBtn.bottom).offset(0);
    make.right.equalTo(self.photoBtn.right).offset(-11);
    make.width.height.equalTo(size.width);

  }];
}
    return self;
}
-(void)pickPhoto:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}
@end
