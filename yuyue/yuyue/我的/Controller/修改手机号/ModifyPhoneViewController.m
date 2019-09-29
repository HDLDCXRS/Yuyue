//
//  ModifyPhoneViewController.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ModifyPhoneViewController.h"

@interface ModifyPhoneViewController ()
@property(nonatomic,strong) UIImageView  *firstLineView;
@property(nonatomic,strong) UIImageView  * lastLineView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLineView];
    self.navigationItem.title =@"修改手机号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
}
-(void)initLineView
{
    self.imgView.backgroundColor = RGBA(243, 243, 243, 1);
    self.navigationItem.title =@"修改手机号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _firstLineView= [[UIImageView alloc] init];
    _firstLineView.backgroundColor = RGBA(230, 230, 230, 1);
    [self.view addSubview:_firstLineView];
    [_firstLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoTextField.bottom).offset(11);
        make.left.equalTo(40);
        make.right.equalTo(-40);
        make.height.equalTo(1);
    }];
    _lastLineView= [[UIImageView alloc] init];
    _lastLineView.backgroundColor = RGBA(230, 230, 230, 1);
    [self.view addSubview:_lastLineView];
    [_lastLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.bottom).offset(11);
        make.left.equalTo(40);
        make.right.equalTo(-40);
        make.height.equalTo(1);
    }];
}


@end
