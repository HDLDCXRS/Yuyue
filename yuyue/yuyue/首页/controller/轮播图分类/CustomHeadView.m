//
//  CustomHeadView.m
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CustomHeadView.h"

@implementation CustomHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    //dataSource:(NSArray *)data andDataSource:(NSArray *)data2
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled =YES;
        _locationBtn = [[CustomeLocationBtn alloc] init];
        [self addSubview:_locationBtn];
        [_locationBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(14);
        }];
       // [_locationBtn layoutIfNeeded];
        _mainADView  = [[MainADView alloc] init];
        [self addSubview:_mainADView];
        [_mainADView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.locationBtn.bottom).offset(22);
            make.left.right.equalTo(0);
            make.height.equalTo(129);
        }];
        [_mainADView layoutIfNeeded];
        _mainADView.timerInterval = 3;
        //_mainADView.dataSourse = data;
        
        _speedView = [[SpeedView alloc] init];
      //  _speedView.userInteractionEnabled =YES;
        [self addSubview:_speedView];
        [_speedView makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.mainADView.bottom).offset(22);
            make.left.right.equalTo(0);
            make.height.equalTo(168);
        }];
        //_speedView.dataSourse =data2;
       // [_speedView layoutIfNeeded];
    }
    return self;
}
@end
