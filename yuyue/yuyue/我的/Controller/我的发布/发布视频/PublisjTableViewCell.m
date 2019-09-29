//
//  PublisjTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/2.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PublisjTableViewCell.h"

@implementation PublisjTableViewCell

-(UITextField*)titleTextField
{
    if (!_titleTextField) {
        _titleTextField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:nil clearsOnBeginEditing:YES andDelegate:self];
        _titleTextField.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _titleTextField.textColor = RGBA(153, 153, 153, 1);
    }
    return _titleTextField;
}
-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _countLabel.textColor = RGBA(153, 153, 153, 1);
    }
    return _countLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    [self.contentView addSubview:self.titleTextField];
    [self.contentView addSubview:self.countLabel];
  
    [self updateConstraintsForView];
}
-(void)updateConstraintsForView
{
    [self.titleTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(14);
        make.left.equalTo(21);
        make.right.equalTo(-51);
        make.bottom.equalTo(-13);
    }];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(14);
        make.right.equalTo(-21);
        make.width.equalTo(30);
        make.height.equalTo(13);
    }];
}

@end
