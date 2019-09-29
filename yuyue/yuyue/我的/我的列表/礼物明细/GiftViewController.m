//
//  GiftViewController.m
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import "GiftViewController.h"
#import "GiftTableViewCell.h"
#import "GitModel.h"
@interface GiftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView   *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSArray  *numberArray;

@end

@implementation GiftViewController

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
    self.navigationItem.title =@"我的评论";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [self requireData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height + 10);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT-NavBar_Height-10);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = RGBA(243, 243, 243, 1);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requireData)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}
-(void)requireData
{
     typeof(self) weakSelf =self;
    [self.manager POST:@"myController/getMoneyList" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"查询成功！"]) {
            weakSelf.numberArray = [NSArray yy_modelArrayWithClass:[GitModel class] json:responseObject[@"result"]];
            
             [weakSelf.tableView reloadData];
             [weakSelf.tableView.mj_header endRefreshing];
            
        }
        else
        {
            weakSelf.tableView.hidden = YES;
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    GiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GiftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    GitModel *model = _numberArray[indexPath.row];
    cell.getMoneyLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    cell.timeLabel.text = model.completeTime;
    cell.titleLabel.text = model.responseMessage;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
 
   

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numberArray.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}

@end
