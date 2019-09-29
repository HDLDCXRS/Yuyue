//
//  CommonView.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        _headView.backgroundColor = RGBA(243, 243, 243, 1);
        [self addSubview:_headView];
        _textView = [[UITextView alloc] init];
        //_textView.text = @"请输入手机号";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
       _textView.attributedText =string;
        _textView.layer.borderColor = RGBA(222, 222, 222, 222).CGColor;
        _textView.layer.borderWidth = 1.0;
       _textView.layer.cornerRadius = 5.0;
        [self addSubview:_textView];
        [_textView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.bottom).offset(0);
            make.right.left.equalTo(0);
            make.height.equalTo(100);
        }];
        
    }
    return self;
}
@end
