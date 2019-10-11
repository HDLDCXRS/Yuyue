//
//  HostStyleViewController.m
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HostStyleViewController.h"
#import "HostStyleView.h"
@interface HostStyleViewController ()
@property(nonatomic,strong) HostStyleView  *styleView;
@end

@implementation HostStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _styleView = [[HostStyleView alloc] init];
    [self.view addSubview:_styleView];
    [_styleView makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(0);
        make.top.equalTo(0);
    }];
     typeof(self) weakSelf = self;
    _styleView.backClick = ^(UIButton * _Nonnull btn) {
        switch (btn.tag) {
            case 1:
                [weakSelf.navigationController popViewControllerAnimated:YES];
                break;
            case 2:
                [weakSelf.navigationController popViewControllerAnimated:YES];
                break;
                
            default:
                break;
        }
    };
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


@end
