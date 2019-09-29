//
//  ChangePasswordViewController.m
//  yuYue
//
//  Created by edz on 2019/8/15.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgcView;
@property (weak, nonatomic) IBOutlet UITextField *inputOldPassworld;
@property (weak, nonatomic) IBOutlet UITextField *inputNewPassworld;
@property (weak, nonatomic) IBOutlet UITextField *commitPassworld;
@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;
@property(nonatomic,strong) AFHTTPSessionManager  * manager;

@end

@implementation ChangePasswordViewController
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
    self.navigationItem.title =@"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _bgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [_CommitBtn  addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    _inputNewPassworld.delegate =self;
    _commitPassworld.delegate = self;
 
}
-(void)onclick
{
    NSDictionary *dic = @{
                          @"password":_inputNewPassworld.text,
                          @"oldPassword":_inputOldPassworld.text
                          };
    if (_inputNewPassworld.text != nil && _commitPassworld.text!=nil) {
        if ([_inputNewPassworld.text isEqualToString:_commitPassworld.text]) {
            [self.manager POST:@"login/updateAppUser?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"message"] isEqualToString:@"修改成功！"]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
               else
               {
                   UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"修改失败" andCancelInfo:@"确定"];
                   [self presentViewController:alter animated:YES completion:nil];
               }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        }
        else
        {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"两次密码不一样" andCancelInfo:@"确定"];
            [self presentViewController:alter animated:YES completion:nil];
        }
    }
}


@end
