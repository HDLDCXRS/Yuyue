//
//  VideoViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCell.h"
#import "VideoModel.h"
#import "AppUserModel.h"
#import "CustomSearchView.h"
#import "DetailVideoViewController.h" //视频详情页面
@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) NSInteger   page;
@property(nonatomic,strong) NSMutableArray  *videoArr;
@property(nonatomic,strong) CustomSearchView  *searchView;

@end
@implementation VideoViewController

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
    [self initSearchView];
    [self initWithTableView];
}
-(void)initSearchView
{
    _searchView = [[CustomSearchView alloc] init];
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 16;
    _searchView.backgroundColor = RGBA(239, 239, 239, 1);
    [self.view addSubview:_searchView];
    [_searchView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(32);
    }];
    [_searchView.textSearchField addTarget:self action:@selector(searchMthod) forControlEvents:UIControlEventEditingDidEnd];
    self.navigationItem.title = @"视频";
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
}
//
-(void)searchMthod
{
    DetailVideoViewController *vc = [[DetailVideoViewController alloc] init];
    vc.searchStr = _searchView.textSearchField.text;
    [self.navigationController pushViewController:vc animated:YES];
}
//tableView的方法
-(void)initWithTableView
{
   
    _tableView = [[UITableView alloc] init];
    _videoArr = [NSMutableArray arrayWithCapacity:4];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height+47);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT-NavBar_Height-32);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _page = 1;
    [self LoadData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
    [self.tableView.mj_footer beginRefreshing];
    //
    
}
#pragma mark  tableViewDelegate  datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"messageCell";
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.bgcModel = _videoArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 221;
}
//获取数据
-(void)LoadData
{
    self.page=1;
    [self.videoArr removeAllObjects];
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)self.page]
                          };
     typeof(self) weakSelf = self;
        [self.manager POST:@"homePage/getVideoToHomePage" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue] == true) {
                weakSelf.videoArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
                //NSLog(@"%lu",(unsigned long)arr.count);
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
        }];

}
//加载更多
-(void)LoadMoreData
{
    //_page +=1;
    self.page = self.page +1;
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",self.page]
                          };
    typeof(self) weakSelf = self;
    NSLog(@"%ld",(long)self.page);
    [self.manager POST:@"homePage/getVideoToHomePage" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSMutableArray *mustArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
            if (mustArr.count == 0) {
                self.page =1;
                [weakSelf.tableView.mj_footer endRefreshing];
//                [weakSelf.tableView reloadData];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [weakSelf.videoArr addObjectsFromArray:mustArr];
                   // [mustArr addObjectsFromArray:weakSelf.videoArr];
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                });
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
         [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"++++++");
}
@end
