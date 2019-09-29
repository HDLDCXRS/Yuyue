//
//  FeedSuccessViewController.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FeedSuccessViewController.h"

@interface FeedSuccessViewController ()
@property(nonatomic,strong) UIImageView  *bgcView;
@property(nonatomic,strong) UIImageView  *imgView;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UIButton  *closeBtn;
@end

@implementation FeedSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}
-(void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _bgcView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREENWIDTH, 10)];
    _bgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [self.view addSubview:_bgcView];
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"对"]];
    CGSize size = _imgView.image.size;
    [self.view addSubview:_imgView];
    [_imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgcView.bottom).offset(107);
        make.centerX.equalTo(self.view.centerX);
        make.width.equalTo(size.width);
        make.height.equalTo(size.height);
    }];
    //
    _titleLabel = [UILabel labelWithBgColor:[UIColor whiteColor] text:@"反馈提交成功!" textColor:RGBA(51, 51, 51, 1) fontSize:18.0 textAlignment:NSTextAlignmentCenter];
    _titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 18];
    [self.view addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.bottom).offset(36);
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(17);
    }];
    _closeBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"关闭" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(closeMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    [_closeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-193);
        make.left.equalTo(15);
        make.right.equalTo(-16);
        make.height.equalTo(44);
    }];
}
-(void)closeMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
