//
//  ForgetPasswordViewController.m
//  yuYue
//
//  Created by edz on 2019/8/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginView.h"
#import "CheckCode.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) LoginView  * LoginPage;
@property(nonatomic,strong) AFHTTPSessionManager  * manager;
@property(nonatomic,strong) UIImageView  *bgcImgView;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title =@"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = [UIColor whiteColor];
    _bgcImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREENWIDTH, 10)];
    _bgcImgView.backgroundColor = RGBA(243,243,243,1);
    [self.view addSubview:_bgcImgView];
     _LoginPage = [[LoginView alloc] init];
    _LoginPage.photoTextField.delegate =self ;
    _LoginPage.photoCodeTextField.delegate = self;
    [self.view addSubview:_LoginPage];
    [_LoginPage.loginingBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_LoginPage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgcImgView.bottom).offset(10);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(0);
    }];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    typeof(self) weakSelf = self;
    _LoginPage.clickBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
                [weakSelf.LoginPage timeFailBeginFrom:5];
                break;
            case 1:
                NSLog(@"%ld",(long)index);
                break;
            case 2:
                NSLog(@"%ld",(long)index);
                [weakSelf.navigationController popViewControllerAnimated:YES];
                break;
                
            default:
                break;
        };
    };
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _LoginPage.photoTextField) {
        [CheckCode validateMobile:_LoginPage.photoTextField.text postUIViewController:self];
    }
    
}
-(void)userLoging
{
    if (_LoginPage.photoCodeTextField.text.length == 0) {
        UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"验证码不能为空" andCancelInfo:@"确定"];
        [self presentViewController:alter animated:YES completion:nil];
    }
    else
    {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.LoginPage.photoTextField.text,@"phone" ,self.LoginPage.photoCodeTextField.text,@"password",nil];
    [_manager POST:@"?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    }
}
//获取验证码
-(void)getSendMessage
{
    if ([CheckCode validateMobile:_LoginPage.photoTextField.text postUIViewController:self]) {
        [_LoginPage timeFailBeginFrom:60];
        NSDictionary *dic = @{
                              @"mobile":self.LoginPage.photoTextField.text
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
@end
