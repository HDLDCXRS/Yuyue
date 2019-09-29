//
//  RegistLoginViewController.m
//  yuYue
//
//  Created by edz on 2019/8/15.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RegistLoginViewController.h"
#import "RegistLoginView.h"
#import "CheckCode.h"
@interface RegistLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) RegistLoginView  *reginLoginView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) NSInteger  count;
@end

@implementation RegistLoginViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        //[_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _reginLoginView = [[RegistLoginView alloc] init];
    [self.view addSubview:_reginLoginView];
    [_reginLoginView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    _reginLoginView.reginstView_one.inputTextField.delegate = self;
    _reginLoginView.reginstView_three.inputTextField.delegate =self;
    _reginLoginView.reginstView_four.inputTextField.delegate = self;
    typeof(self) weakSelf = self;
    _reginLoginView.click = ^(NSInteger index) {
        switch (index) {
            case 1:
                NSLog(@"%ld",(long)index);
                break;
            case 2:
                [weakSelf postURL];
                NSLog(@"%ld",(long)index);
                break;
                
            default:
                break;
        }
    };
    _reginLoginView.reginstView_two.click = ^(UIButton * _Nonnull btn) {
        [weakSelf.reginLoginView.reginstView_two timeFailBeginFrom:60];
        [weakSelf sendSmsMethod];
    };
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _reginLoginView.reginstView_one.inputTextField) {
        [CheckCode validateMobile:textField.text postUIViewController:self];
    }
    else if (textField == _reginLoginView.reginstView_three.inputTextField)
    {
        if (![CheckCode validatePassword:textField.text ]) {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"密码输入不正确" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:^{}];
        }
    }
    else if (textField ==_reginLoginView.reginstView_four.inputTextField ) {
        if (![_reginLoginView.reginstView_four.inputTextField.text isEqualToString:_reginLoginView.reginstView_three.inputTextField.text] ) {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"两次密码输入不一样" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:^{}];
        }
        else
            return;
    }
    
}
-(void)sendSmsMethod
{
    NSDictionary *dic = @{
                          @"mobile":_reginLoginView.reginstView_one.inputTextField.text
                          };
    [_manager POST:@"send/sendSms?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"短信发送成功!"]) {
            NSLog(@"+++++");
        }
        else
        {
            NSLog(@"-----");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----");
    }];
}
-(void)postURL
{
    NSDictionary *dic = @{
                          @"phone":_reginLoginView.reginstView_one.inputTextField.text,
                          @"code" :_reginLoginView.reginstView_two.inputTextField.text,
                          @"password":_reginLoginView.reginstView_four.inputTextField.text
                          };
    [self.manager POST:@"login/regist?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"注册成功！"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([responseObject[@"message"] isEqualToString:@"该号码已注册！"])
        {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"该号码已注册" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:nil];
        }
        else {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"验证码不正确" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----");
    }];
}

@end
