//
//  MineMoneyViewController.m
//  yuYue
//
//  Created by edz on 2019/8/7.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineMoneyViewController.h"
#import "MineMoneyView.h"
#import "RechangMoneyViewController.h"
#import "MyWithDrawalViewController.h"
#import "LoginModel.h"
@interface MineMoneyViewController ()
@property(nonatomic,strong) MineMoneyView  *mineView;
@property(nonatomic,strong) UIImageView  *bgcView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) double count;
@end

@implementation MineMoneyViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        //
        [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self headRefresh];
    _bgcView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREENWIDTH, 10)];
    _bgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [self.view addSubview:_bgcView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的钱包";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(51, 51, 51, 1),NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size: 18]}];
    _mineView = [[MineMoneyView alloc] init];
    [self.view addSubview:_mineView];
    [_mineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgcView.bottom).offset(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    // 充值
    typeof(self)  weakSelf = self;
    _mineView.lastMoneyView.clickBtn = ^(UIButton * _Nonnull btn) {
        NSLog(@"++++++");
        RechangMoneyViewController *vc = [[RechangMoneyViewController alloc] init];
        [ weakSelf.navigationController pushViewController:vc animated:YES];
    };
    //提现
    _mineView.getMoneyView.clickBtn = ^(UIButton * _Nonnull btn) {
        MyWithDrawalViewController *vc = [[MyWithDrawalViewController alloc] init];
        vc.count = weakSelf.count;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)headRefresh{
        typeof(self) weakSelf =self;
        [self.manager POST:@"login/getMessage" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"message"] isEqualToString:@"获取成功！"]) {
                LoginModel *model = [LoginModel yy_modelWithDictionary:responseObject[@"result"]];
                weakSelf.mineView.model = model;
                weakSelf.count = model.income;
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
    
   // [self getData];
    
}


@end
