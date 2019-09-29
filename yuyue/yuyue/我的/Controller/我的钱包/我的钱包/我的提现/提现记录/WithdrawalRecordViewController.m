//
//  WithdrawalRecordViewController.m
//  yuyue
//
//  Created by edz on 2019/9/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "WithdrawalRecordViewController.h"
#import "WithdrawalrecordTableViewCell.h"
#import "WithdrawalRecordModel.h"
@interface WithdrawalRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation WithdrawalRecordViewController
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [self RrequestData];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height +10);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT - NavBar_Height - 10);
    }];
  
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    self.navigationItem.title =@"提现记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
     [_tableView   registerClass:[WithdrawalrecordTableViewCell class] forCellReuseIdentifier:@"cellD2"];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawalrecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellD2"];
    cell.model = _dataArray[indexPath.row];
    return cell;
}
-(void)RrequestData
{
     typeof(self) weakSelf = self;
    [self.manager POST:@"myController/getOutMoneyList" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            weakSelf.dataArray = [NSArray yy_modelArrayWithClass:[WithdrawalRecordModel class] json:responseObject[@"result"]];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"暂无提现记录"];
           // _minimumDismissTimeInterval = 2；
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
