//
//  ReginstLoginstCommonView.m
//  yuyue
//
//  Created by edz on 2019/9/10.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ReginstLoginstCommonView.h"

@implementation ReginstLoginstCommonView
- (instancetype)initWithFrame:(CGRect)frame setImage:(NSString *)str setText:(NSString *)text getStuat:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image  = [UIImage imageNamed:str];
        CGSize size = _iconView.image.size;
        [self addSubview:_iconView];
        [_iconView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(36);
            make.left.equalTo(39);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
      
        _inputTextField = [UITextField textFieldWithFrame:CGRectZero background:nil placeholder:text clearsOnBeginEditing:YES andDelegate:self];
        _inputTextField.font =  [UIFont fontWithName:@"PingFang SC" size: 15];
        _inputTextField.textColor = RGBA(133, 133, 133, 1);
        [self addSubview:_inputTextField];
        [_inputTextField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconView.centerY);
            make.left.equalTo(self.iconView.right).offset(15);
            make.right.equalTo(-39);
            make.height.equalTo(14);
        }];
        
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor = RGBA(214, 214, 214, 1);
        [self addSubview:_lineView];
        [_lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inputTextField.bottom).offset(14);
            make.left.equalTo(39);
            make.right.equalTo(-39);
            make.height.equalTo(1);
        }];
        if (isShow) {
            _getCodeBtn = [UIButton buttonWithFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:@"获取验证码" setTitleColor:RGBA(26, 151, 224, 1) state:UIControlStateNormal addTarget:self action:@selector(TimerMethod:) forControlEvents:UIControlEventTouchUpInside];
            _getCodeBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
            _getCodeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_getCodeBtn];
            [_getCodeBtn makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.iconView.centerY);
                make.right.equalTo(-46);
                make.width.equalTo(70);
                make.height.equalTo(13);
            }];
        }
    }
    return self;
}
-(void)TimerMethod:(UIButton *)btn
{
    if (_click) {
        _click(btn);
    }
}
- (void)timeFailBeginFrom:(NSInteger)timeCount
{
    self.count = timeCount;
    self.getCodeBtn.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
}
#pragma mark - 定时器事件
- (void)timeDown
{
    if (self.count != 1){
        
        self.count -=1;
        self.getCodeBtn.enabled = NO;
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateNormal];
        
    } else {
        
        self.getCodeBtn.enabled = YES;
        [self.getCodeBtn setTitle:@"再次获取" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}
@end
