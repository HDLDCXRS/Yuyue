//
//  MyWithDrawalViewController.m
//  yuyue
//
//  Created by edz on 2019/9/25.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MyWithDrawalViewController.h"
#import "MyWithDrawalView.h"

#import "WithdrawalRecordViewController.h"
@interface MyWithDrawalViewController ()
@property(nonatomic,strong) MyWithDrawalView  *withDrawalView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSMutableDictionary  *dic;
@end

@implementation MyWithDrawalViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavagation];
    self.view.backgroundColor = [UIColor whiteColor];
    _dic = [NSMutableDictionary dictionaryWithCapacity:3];
    self.navigationItem.title =@"我的提现";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _withDrawalView = [[MyWithDrawalView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_withDrawalView];
    [_withDrawalView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT -NavBar_Height);
    }];
    typeof(self) weakSelf = self;
    _withDrawalView.jinELabel.text = [NSString stringWithFormat:@"%.2f",_count];
    _withDrawalView.click = ^(UIButton * _Nonnull btn) {
        [weakSelf postUrl];
    } ;
    [_withDrawalView.appTextField addTarget:self action:@selector(textFieldExchanged:) forControlEvents:UIControlEventEditingDidEnd];
}
-(void)textFieldExchanged:(UITextField*)textField
{
    [_dic setValue:textField.text forKey:@"money"];
    //NSLog(@"%@",_dic);
}

-(void)postUrl
{
    NSLog(@"%@",_dic);
    NSString *openID = [[NSUserDefaults standardUserDefaults]valueForKey:@"opendId"];
    [_dic setValue:openID forKey:@"opendId" ];
    [_dic setValue:@"TXWX" forKey:@"tradeType"];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
    [self.manager POST:@"pay/outMoney" parameters:_dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        }
        else
        {
            [SVProgressHUD  showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)initNavagation
{
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton  *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,36, 60,13)];
    [rightBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBA(102, 102,102, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 14];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)rightBtnClick
{
    WithdrawalRecordViewController *vc = [[WithdrawalRecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
