//
//  PhomeNumberViewController.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PhomeNumberViewController.h"
#import "CommonView.h"
@interface PhomeNumberViewController ()
 @property(nonatomic,strong) CommonView  *conmmView;
@end

@implementation PhomeNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _conmmView = [[CommonView alloc] init];
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    [self.view addSubview:_conmmView];
    [_conmmView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}


@end
