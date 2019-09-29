//
//  MainLoginViewController.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MainLoginViewController.h"
#import "RegistLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "LoginView.h"
#import "CodeView.h"
#import "CheckCode.h"
@interface MainLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIButton  * codeLoginBtn;
@property(nonatomic,strong) UIButton  * passwordBtn;
@property(nonatomic,assign) CGSize  size;
@property(nonatomic,assign)CGSize  pwdSize;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
//视图
@property(nonatomic,strong) LoginView  *loginView;
@property(nonatomic,strong) CodeView *codeView;
@end

@implementation MainLoginViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        //
        // [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithSetUI];
    [self initNavagation];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]);
}
-(void) initWithSetUI
{
    _codeLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_codeLoginBtn setBackgroundImage:[UIImage imageNamed:@"验证码蓝色"] forState:UIControlStateNormal];
    [_codeLoginBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _codeLoginBtn.tag = 0;
    _size = _codeLoginBtn.currentBackgroundImage.size;
    [self.view addSubview:_codeLoginBtn];
    [_codeLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(97);
        make.top.equalTo(Status_Height+ NavBar_Height+42);
        make.width.equalTo(self.size.width);
        make.height.equalTo(self.size.height);
    }];
    _passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_passwordBtn setBackgroundImage:[UIImage imageNamed:@"密码登录"] forState:UIControlStateNormal];
    [_passwordBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_passwordBtn];
    _pwdSize = _passwordBtn.currentBackgroundImage.size;
    [_passwordBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Status_Height+ NavBar_Height+42);
        make.right.equalTo(-97);
        make.width.equalTo(self.pwdSize.width);
        make.height.equalTo(self.pwdSize.height);
    }];
    _passwordBtn.tag = 1;
    //验证码登录视图
    _loginView = [[LoginView alloc] init];
    [self.view addSubview:_loginView];
    [_loginView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBtn.bottom).offset(55);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(0);
    }];
    _loginView.photoTextField.delegate =self;
    _loginView.photoCodeTextField.delegate = self;
    typeof(self) weakSelf = self;
    _loginView.clickBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
                [weakSelf.loginView timeFailBeginFrom:60];
                break;
            case 1:
                [weakSelf codeLoging];
                break;
            default:
                break;
        }
    };
    //验证码
    _codeView = [[CodeView alloc] init];
    [self.view addSubview:_codeView];
    [_codeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBtn.bottom).offset(55);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(0);
    }];
    _codeView.photoTextField.delegate = self;
    _codeView.passwordTextField.delegate =self;
    _codeView.clickBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
            {
                ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 1:
                [weakSelf passwordLoging];
                break;
            default:
                break;
        }
    };
    [self switchToVcAtIndex:0];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _loginView.photoTextField) {
        [CheckCode validateMobile:_loginView.photoTextField.text postUIViewController:self];
    }
    else if (textField == _codeView.photoTextField)
    {
        [CheckCode validateMobile:_codeView.photoTextField.text postUIViewController:self];
    }
    else if (textField == _codeView.passwordTextField)
    {
        [CheckCode validatePassword:_codeView.passwordTextField.text];
    }
}
-(void)switchToVcAtIndex:(int)index
{   
    switch (index) {
        case 0:
            [_codeLoginBtn setBackgroundImage:[UIImage imageNamed:@"验证码蓝色"] forState:UIControlStateNormal];
            [_passwordBtn setBackgroundImage:[UIImage imageNamed:@"密码登录"] forState:UIControlStateNormal];
            [self updateMonsary];
            _codeView.hidden =YES;
            _loginView.hidden =NO;
    
            break;
        case 1:
            [_codeLoginBtn setBackgroundImage:[UIImage imageNamed:@"验证码登录"] forState:UIControlStateNormal];
            [_passwordBtn setBackgroundImage:[UIImage imageNamed:@"密码登录蓝色"] forState:UIControlStateNormal];
            [self updateMonsary];
            _codeView.hidden =NO;
            _loginView.hidden =YES;
            break;
        default:
            break;
    }
}
-(void)onClick:(UIButton *)btn
{
    if (btn.tag == 0  ) {
        [self switchToVcAtIndex:0];
        
    }
    else
    {
        [self switchToVcAtIndex:1];
    }
}
//更新约束
-(void)updateMonsary
{
    _size =_codeLoginBtn.currentBackgroundImage.size;
    [_codeLoginBtn updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.size.height);
    }];
    _pwdSize = _passwordBtn.currentBackgroundImage.size;
    [_passwordBtn updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.pwdSize.height);
    }];
}
//设置导航
-(void)initNavagation
{
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton  *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,36, 31,15)];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 16];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)rightBtnClick
{
    RegistLoginViewController *vc = [[RegistLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)passwordLoging
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_codeView.photoTextField.text,@"phone" ,self.codeView.passwordTextField.text,@"password", nil];
    [self.manager POST:@"login/loginByPassword" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"登录成功！"]) {
            NSLog(@"%@",responseObject);
             [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"token"] forKey:@"token"];
               [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"opendId"] forKey:@"opendId"];
             [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"result"][@"userType"] forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"result"][@"nickName"] forKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LoginModel *model = [LoginModel yy_modelWithDictionary:responseObject[@"result"]];
            if (self.returnValueBlock) {
                self.returnValueBlock(model);
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"友情提示" andMessage:@"密码错误" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:^{}];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//验证码登录
-(void)codeLoging
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.loginView.photoTextField.text,@"phone" ,self.loginView.photoCodeTextField.text,@"code",nil];
    [self.manager POST:@"login/loginByPhone" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"登录成功！"]) {
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"token"] forKey:@"token"];
            
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"result"][@"userType"] forKey:@"userType"];
            
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"result"][@"nickName"] forKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LoginModel *model = [LoginModel yy_modelWithDictionary:responseObject[@"result"]];
            if (self.returnValueBlock) {
                self.returnValueBlock(model);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"友情提示" andMessage:@"验证码不正确" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:^{}];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//获取验证码
-(void)getSendMessage
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.loginView.photoTextField.text,@"phone",nil];
    [_manager POST:@"send/sendSms" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"发送成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
