//
//  DetailSceneTableViewController.m
//  yuyue
//
//  Created by edz on 2019/9/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DetailSceneTableViewController.h"
#import "DetailScenceTableViewCell.h"
#import "ShowTableViewCell.h"
#import "ShowSiteModel.h"
#import "ShowModel.h"
@interface DetailSceneTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) ShowSiteModel *model ;
@property(nonatomic,strong) NSArray *modelArray;
@end

@implementation DetailSceneTableViewController
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"现场详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [self requestData];
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT -NavBar_Height);
    }];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_tableView  registerClass:[DetailScenceTableViewCell class] forCellReuseIdentifier:@"cellD1"];
    [_tableView   registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"cellD2"];;

}
-(void)requestData
{
    NSDictionary *dic = @{
                          @"id":@"175FDFCD731E74AC095F00F6A0B35296"
                          };
    typeof(self) weakSelf = self;
    [self.manager POST:@"homePage/getSite?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"节目表单返回成功"]) {
            weakSelf.model = [ShowSiteModel yy_modelWithJSON:responseObject[@"result"][@"site"]];
            
            weakSelf.modelArray = [NSArray yy_modelArrayWithClass:[ShowModel class] json:responseObject[@"result"][@"showList"]];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return _modelArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableView *cell = nil;

    if (indexPath.section == 0) {
       DetailScenceTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellD1"];
       cell.model = _model;
       return cell;
    }
    else
    {
        ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellD2"];
        if (indexPath.item >0) {
            cell.model = _modelArray[indexPath.row -1];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat min_h = [_model.title textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:139].height;
    if (indexPath.section == 0) {
        return 332 + min_h;
    }
    else
    {
      return 49;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 5)];
    headerView.backgroundColor = RGBA(243, 243, 243, 1);
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
@end
