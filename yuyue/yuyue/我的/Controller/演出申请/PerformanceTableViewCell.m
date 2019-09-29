//
//  PerformanceTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PerformanceTableViewCell.h"

@implementation PerformanceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
        _titleLabel.textColor = RGBA(51, 51, 51, 1);
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.left.equalTo(18);
            make.height.equalTo(15);
            make.width.equalTo(80);
        }];
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.font = [UIFont fontWithName:@"PingFang SC" size: 16];
        _inputTextField.textColor = RGBA(51, 51, 51, 1);
        _inputTextField.textAlignment =NSTextAlignmentRight;
        _inputTextField.clearsOnBeginEditing =YES;
        [self addSubview:_inputTextField];
        [_inputTextField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.height.equalTo(15);
            make.right.equalTo(-15);
            make.left.equalTo(self.titleLabel.right).offset(0);
        }];
    }
    return self;
}

@end
