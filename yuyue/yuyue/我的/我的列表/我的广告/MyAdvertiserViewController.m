//
//  MyAdvertiserViewController.m
//  yuyue
//
//  Created by edz on 2019/9/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MyAdvertiserViewController.h"
#import "MyAdvertisingTableViewCell.h"
#import "MyAdvertiserModel.h"
#import "NoDataView.h"
@interface MyAdvertiserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSArray  *arrCount;
@property(nonatomic,strong)  NoDataView* dataView  ;
@end

@implementation MyAdvertiserViewController
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
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.navigationItem.title =@"我的广告";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height+10);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT - NavBar_Height-10);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _dataView = [[NoDataView alloc] initWithFrame:CGRectMake(0,NavBar_Height+10, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:_dataView];
  //  [_tableView layoutIfNeeded];
    [self requestData];
}
-(void)requestData
{
    typeof(self) weakSelf =self;
    [self.manager POST:@"myController/getHotSaleCommodityInfo" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] intValue] == 1) {
            weakSelf.arrCount = [NSArray yy_modelArrayWithClass:[MyAdvertiserModel class] json:responseObject[@"result"]];
            if (weakSelf.arrCount != nil && ![weakSelf.arrCount isKindOfClass:[NSNull class]] && weakSelf.arrCount.count != 0){
                weakSelf.tableView.hidden = NO;
                weakSelf.dataView.hidden = YES;
            }
            else
            {
                weakSelf.tableView.hidden = YES;
                weakSelf.dataView.hidden = NO;
            }
            [weakSelf.tableView reloadData];
        }
        else
        {
            weakSelf.tableView.hidden = YES;
            weakSelf.dataView.hidden = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCount.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cell";
    MyAdvertisingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MyAdvertisingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.model = _arrCount[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 405;
}

@end
