//
//  BaseCommonTableViewCell.m
//  yuyue
//
//  Created by edz on 2019/9/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BaseCommonTableViewCell.h"

@implementation BaseCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titlleLabel = [[UILabel alloc] init];
        _titlleLabel.text = @"昵称";
        _titlleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        _titlleLabel.textColor = RGBA(102, 102, 102, 1);
        int height = [self getStrHeight:_titlleLabel.text withFont:14 withWidth:106];
        //        int width = [self getStrWidth:_titlleLabel.text withFont:14.0];
        
        [self.contentView addSubview:_titlleLabel];
        [_titlleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(18);
            make.top.equalTo(19);
            make.width.equalTo(42);
            make.height.equalTo(height);
        }];
        _inputTextField = [[UILabel alloc] init];
        _inputTextField.textColor = RGBA(153, 153, 153, 1);
        _inputTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        [self.contentView addSubview:_inputTextField];
        [_inputTextField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(19);
            make.left.equalTo(self.titlleLabel.right).offset(63);
            make.right.equalTo(-40);
            make.height.equalTo(13);
        }];
    }
    return self;
}
//获取字体宽度
-(CGFloat)getStrHeight:(NSString *)string withFont:(CGFloat)font withWidth:(NSInteger)width
{
    NSDictionary *attr=  @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: font]};CGSize sizeHeigth = [string boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;return sizeHeigth.height;
    
}
-(CGFloat)getStrWidth:(NSString *)string withFont:(CGFloat)font
{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: font]}];
    return size.width;
    
}

@end
