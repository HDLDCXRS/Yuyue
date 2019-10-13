//
//  ModifyPhoneViewController.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ModifyPhoneViewController.h"
#import "ReginstLoginstCommonView.h"
#import "CheckCode.h"
@interface ModifyPhoneViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIImageView  *imageView;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_one;
@property(nonatomic,strong) ReginstLoginstCommonView  *reginstView_two;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) UIButton  *commitBtn;

@end

@implementation ModifyPhoneViewController
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
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREENWIDTH, 10)];
    _imageView.backgroundColor = RGBA(243, 243, 243, 1);
    [self.view addSubview:_imageView];
    self.navigationItem.title =@"修改手机号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _reginstView_one = [[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"" setText:@"请输入新手机号" getStuat:NO];
    _reginstView_one.inputTextField.delegate = self;
    [self.view addSubview:_reginstView_one];
    [_reginstView_one makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.bottom).offset(10);
        make.right.left.equalTo(0);
        make.height.equalTo(50);
    }];
    
    _reginstView_two = [[ReginstLoginstCommonView alloc] initWithFrame:CGRectZero setImage:@"" setText:@"再次输入手机号" getStuat:YES];
    [self.view addSubview:_reginstView_two];
    [_reginstView_two makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reginstView_one.bottom).offset(10);
        make.right.left.equalTo(0);
        make.height.equalTo(50);
    }];
    _reginstView_two.inputTextField.delegate =self;
    [_reginstView_two.getCodeBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn  = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"确定" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(commitMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    [_commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.centerY);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(44);
    }];
    
}
-(void)onClick
{
    [self getSendMessage];
}
-(void)commitMethod
{
    if (_reginstView_two.inputTextField.text.length == 0) {
        UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"验证码不能为空" andCancelInfo:@"确定"];
        [self presentViewController:alter animated:YES completion:nil];
    }
    else
    {
        NSDictionary *dic = @{
                              @"phone":_reginstView_one.inputTextField.text,
                              @"code":_reginstView_two.inputTextField.text
                              };
        
        typeof(self) weakSelf = self;
        [self.manager POST:@"login/updateAppUser" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue] == true) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"+++++");
        }];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.reginstView_one.inputTextField) {
         [CheckCode validateMobile:self.reginstView_one.inputTextField.text postUIViewController:self];
    }
}
//获取验证码
-(void)getSendMessage
{
    if ([CheckCode validateMobile:_reginstView_one.inputTextField.text postUIViewController:self]) {
        [_reginstView_two timeFailBeginFrom:60];
        NSDictionary *dic = @{
                              @"mobile":self.reginstView_one.inputTextField.text
                              };
        [self.manager POST:@"send/sendSms?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue]== true) {
                NSLog(@"发送成功");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}
#pragma mark - 定时器事件

@end
