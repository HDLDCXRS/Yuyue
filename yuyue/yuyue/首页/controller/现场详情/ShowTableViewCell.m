//
//  ShowTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ShowTableViewCell.h"
#define  min_w   SCREENWIDTH/3
@implementation ShowTableViewCell
- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _rightLabel.textColor = RGBA(102, 102, 102, 1);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.text =@"分类";
      
    }
    return _rightLabel;
}
- (UILabel *)minLabel
{
    if (!_minLabel) {
        _minLabel = [[UILabel alloc] init];
        _minLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
        _minLabel.textColor =RGBA(102, 102, 102, 1);
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.text = @"节目名称";
    }
    return _minLabel;
}
- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
        _leftLabel.textColor = RGBA(102, 102, 102, 1);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.text = @"艺名";
    }
    return _leftLabel;
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
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.minLabel];
    [self.contentView addSubview:self.rightLabel];
    [self updateConstraintsForView];
}
- (void)updateConstraintsForView
{
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(min_w, 13));
    }];
    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(min_w, 13));
    }];
    [self.minLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(self.leftLabel.right).offset(0);
        make.right.equalTo(self.rightLabel.left).offset(0);
        make.height.equalTo(13);
    }];
}
-(void)setModel:(ShowModel * _Nonnull)model
{
    self.leftLabel.textColor = RGBA(51, 51, 51, 1);
    self.minLabel.textColor =RGBA(51, 51, 51, 1);
    self.rightLabel.textColor  = RGBA(51, 51, 51, 1);
    self.leftLabel.text = model.showPersons;
    self.minLabel.text = model.showName;
    self.rightLabel.text = model.category;
    
}

@end
