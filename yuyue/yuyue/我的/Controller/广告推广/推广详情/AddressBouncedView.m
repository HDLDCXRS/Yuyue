//
//  AddressBouncedView.m
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "AddressBouncedView.h"

@implementation AddressBouncedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _siteLabe = [[UILabel alloc] init];
        _siteLabe.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _siteLabe.textColor = RGBA(51, 51, 51, 1);
        _siteLabe.text = @"添加地址";
        _siteLabe.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_siteLabe];
        [_siteLabe makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(16);
            make.left.right.equalTo(0);
            make.height.equalTo(14);
        }];
        _cancleBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"关  闭"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleBtn];
        _cancleBtn.tag = 1;
        CGSize size = _cancleBtn.currentBackgroundImage.size;
        [_cancleBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.siteLabe.centerY);
            make.right.equalTo(-15);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        UIImageView *line1 = [[UIImageView alloc] init];
         line1.backgroundColor = RGBA(230, 230, 230, 1);
        [self addSubview:line1];
        [line1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancleBtn.bottom).offset(14);
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(1);
        }];
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _selectLabel.textColor = RGBA(51, 51, 51, 1);
        _selectLabel.text = @"选择地区";
        [self addSubview:_selectLabel];
        [_selectLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.bottom).offset(13);
            make.left.equalTo(5);
            make.right.equalTo(0);
            make.height.equalTo(13);
        }];
        _jiantouBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"右箭头"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _jiantouBtn.tag =2;
        size = _jiantouBtn.currentBackgroundImage.size;
        [self addSubview:_jiantouBtn];
        [_jiantouBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selectLabel.centerY);
            make.right.equalTo(-15);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
        UIImageView *line2 = [[UIImageView alloc] init];
        line2.backgroundColor = RGBA(230, 230, 230, 1);
        [self addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jiantouBtn.bottom).offset(14);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
        }];
        _detailField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:@"详细地址（如街道、小区、乡镇、村）" clearsOnBeginEditing:YES andDelegate:self];
        _detailField.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _detailField.textColor = RGBA(153, 153, 153, 1);
        [self addSubview:_detailField];
        [_detailField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.bottom).offset(13);
            make.left.equalTo(5);
            make.right.equalTo(0);
            make.height.equalTo(13);
        }];
        UIImageView *line3 = [[UIImageView alloc] init];
        line3.backgroundColor = RGBA(230, 230, 230, 1);
        [self addSubview:line3];
        [line3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailField.bottom).offset(14);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
        }];
        _saveBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"保存" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 3;
        [self addSubview:_saveBtn];
        [_saveBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3.bottom).offset(13);
            make.height.equalTo(37);
            make.left.equalTo(14);
            make.right.equalTo(-14);
        }];
        
    }
    return self;
}
-(void)onClick:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}
@end
