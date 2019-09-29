//
//  MinePublishViewController.m
//  yuYue
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MinePublishViewController.h"
#import "MinePublicTableViewCell.h"
#import "PublisVideoViewController.h"
#import "MinePublishModel.h"
@interface MinePublishViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)  UITableView  *aTableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSArray  *countArray;
@end
@implementation MinePublishViewController
- (UITableView *)aTableView
{
    if (!_aTableView) {
        _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.estimatedRowHeight = 100;
        _aTableView.rowHeight = UITableViewAutomaticDimension;
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _aTableView;
}
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
    self.navigationItem.title = @"作品发布";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [self requireData];
   
       [self createUI];
    [self initNavagation];

}
-(void)requireData
{
    typeof(self) weakSelf = self;
    [self.manager POST:@"myController/myRelease" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"返回成功！！"]) {
           weakSelf.countArray = [NSArray yy_modelArrayWithClass:[MinePublishModel class] json:responseObject[@"result"][@"videoList"]];
          [weakSelf.aTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)createUI
{
    [self.view addSubview:self.aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.bottom.equalTo(0);
    }];
    [_aTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _countArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"messageCell";
   MinePublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[ MinePublicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.model = _countArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)initNavagation
{
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton  *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,36, 16,16)];
    [rightBtn setImage:[UIImage imageNamed:@"上传"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)rightBtnClick
{
    PublisVideoViewController *vc = [[PublisVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
