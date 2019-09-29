//
//  PassRealNameViewController.m
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PassRealNameViewController.h"
#import "PassRealNameView.h"
@interface PassRealNameViewController ()
@property(nonatomic,strong) PassRealNameView  *mainView;
@end

@implementation PassRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"实名认证";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _mainView = [[PassRealNameView alloc] init];
    [self.view addSubview:_mainView];
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(NavBar_Height);
    }];
}



@end
