//
//  FeedBackView.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FeedBackView.h"
#import<QuartzCore/QuartzCore.h>
@implementation FeedBackView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgcImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        _bgcImg.backgroundColor = RGBA(243, 243, 243, 1);
        [self addSubview:_bgcImg];
        _titleLabel = [UILabel labelWithBgColor:[UIColor whiteColor] text:@"请描述具体问题" textColor:RGBA(51, 51, 51, 1) fontSize:14 textAlignment:NSTextAlignmentLeft];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgcImg.bottom).offset(17);
            make.left.equalTo(16);
            make.height.equalTo(13);
            make.right.equalTo(0);
        }];
        _contentTextView = [[LYYTextView alloc] init];
        _contentTextView.placeholder = @"异常发生的时间、网络状况、具体位置及表现等";
        _contentTextView.layer.borderColor = RGBA(222, 222, 222, 222).CGColor;
        _contentTextView.layer.borderWidth = 1.0;
        _contentTextView.layer.cornerRadius = 5.0;
        [self addSubview:_contentTextView];
        [_contentTextView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(13);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(125);
        }];
        //限制字数
        _limitLabel = [[UILabel alloc] init];
        _limitLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
        _limitLabel.textColor = RGBA(153,153,153, 1);
        _limitLabel.text = @"0/100";
        _limitLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_limitLabel];
        [_limitLabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentTextView.bottom).offset(-9);
            make.right.equalTo(self.contentTextView.right).offset(-9);
            make.left.equalTo(0);
            make.height.equalTo(14);
            
        }];
        //图片补充
        _photoLabel = [UILabel labelWithBgColor:[UIColor whiteColor] text:@"图片补充" textColor:RGBA(51, 51, 51, 1) fontSize:14 textAlignment:NSTextAlignmentLeft];
        _photoLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        [self addSubview:_photoLabel];
        [_photoLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentTextView.bottom).offset(31);
            make.left.equalTo(17);
            make.height.equalTo(13);
            make.right.equalTo(0);
        }];
       
        _photoBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"加"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(onClickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        _photoBtn.tag = 100;
        CGSize size = _photoBtn.currentBackgroundImage.size;
        [self addSubview:_photoBtn];
        [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photoLabel.bottom).offset(13);
            make.left.equalTo(15);
            make.width.equalTo(size.width);
            make.height.equalTo(size.height);
        }];
      //；联系方式
        _connectLabel = [UILabel labelWithBgColor:[UIColor whiteColor] text:@"图片补充" textColor:RGBA(51, 51, 51, 1) fontSize:14 textAlignment:NSTextAlignmentLeft];
        _connectLabel = [UILabel labelWithBgColor:[UIColor whiteColor] text:@"图片补充" textColor:RGBA(51, 51, 51, 1) fontSize:14 textAlignment:NSTextAlignmentLeft];
        _connectLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        [self addSubview:_connectLabel];
        [_connectLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photoBtn.bottom).offset(14);
            make.left.equalTo(16);
            make.height.equalTo(13);
            make.right.equalTo(0);
        }];
        //
        _textField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:@"请注明是QQ/微信/手机哪一种" clearsOnBeginEditing:YES andDelegate:self];
        _textField.font = [UIFont fontWithName:@"PingFang SC" size: 14];
        _textField.textColor = RGBA(153, 153, 153, 1);
        _textField.layer.borderColor = RGBA(222, 222, 222, 1).CGColor;
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 5.0;
        _textField.layer.borderWidth = 1.0f;
        [self addSubview:_textField];
        [_textField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.connectLabel.bottom).offset(13);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(36);
        }];
        _commitBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"提交" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.tag = 101;
        [self addSubview:_commitBtn];
        [_commitBtn makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-30);
            make.left.equalTo(16);
            make.right.equalTo(-16);
            make.height.equalTo(44);
        }];
    }
    return self;
}
-(void)onClickPhoto:(UIButton*)btn
{
    if (_click) {
        _click(btn);
    }
}
@end
