//
//  BindingAccountViewController.m
//  yuyue
//
//  Created by edz on 2019/9/26.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BindingAccountViewController.h"
#import "WXAuth.h"
@interface BindingAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  *  tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) BOOL  isBangDing  ;
@end
@implementation BindingAccountViewController
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
    
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    NSString *str =[[NSUserDefaults standardUserDefaults] valueForKey:@"opendId" ];
        if (str.length == 0 ) {
            _isBangDing = NO;
        }
        else
        {
            _isBangDing = YES;
        }
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height + 10);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT - NavBar_Height -10);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    _tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WechatAuthSuccessful:)
                                                 name:@"WechatAuthSuccessful"
                                               object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"微信"];
    cell.textLabel.text = @"微信";
    if (!_isBangDing) {
        cell.detailTextLabel.text = @"未绑定";
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    else
    {
        cell.detailTextLabel.text = @"已绑定";
        cell.detailTextLabel.textColor = RGBA(89, 195, 231, 1);
    }
   // cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
    cell.textLabel.textColor = RGBA(51, 51, 51, 1);
    //不显示点击后背景变色
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isBangDing == NO ) {
       [WXAUTH sendWXAuthReq];
    }
    else
    {
        [self logout];
    }
}
//当code取到的时候传给后端
-(void)WechatAuthSuccessful:(NSNotification *)notify
{
    NSDictionary *dic = [notify userInfo];
        typeof(self) weakSelf = self;
        [self.manager POST:@"pay/saveUserInfo" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue] == true) {
                 weakSelf.isBangDing = YES;
                [weakSelf.tableView reloadData];
            }
            else
                NSLog(@"%@",responseObject[@"message"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        }];
}
- (void) logout {
    // 初始化对话框
    typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认注销吗？" preferredStyle:UIAlertControllerStyleAlert];
    // 确定注销
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
         [weakSelf deleteOpendID];
    }];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
-(void)deleteOpendID
{
        typeof(self) weakSelf = self;
        [self.manager POST:@"pay/deleteOpendId?tradeType=WX" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue] == true) {
                 weakSelf.isBangDing = NO;
                [weakSelf.tableView reloadData];
            }
            else
            {
                weakSelf.isBangDing = NO;
                [weakSelf.tableView reloadData];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
