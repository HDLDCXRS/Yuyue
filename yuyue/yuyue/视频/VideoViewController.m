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
#import "ZFCustomControlViewViewController.h"//视频详情播放
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
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
    // 设置文字
    [header setTitle:@"正在刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"正在刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置刷新控件
    self.tableView.mj_header = header;
   
    [self.tableView.mj_header beginRefreshing];
     MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer beginRefreshing];
        [self LoadMoreData];
    }];
    [footer setTitle:@"我是有底线的" forState:MJRefreshStateIdle];
    [footer setTitle:@"我是有底的" forState:MJRefreshStatePulling];
    [footer setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
//     [header setTitle:@"我是有底线的" forState:MJRefreshStateIdle];
      self.tableView.mj_footer = footer;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [btn setImage:[UIImage imageNamed:@"回到顶部"] forState:UIControlStateNormal];
    CGSize size = btn.currentImage.size;
    [self.view addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-TabBar_Height-69);
        make.right.equalTo(-19);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    [btn addTarget:self action:@selector(toTopViewMethod) forControlEvents:UIControlEventTouchUpInside];
}
//回到顶部
-(void)toTopViewMethod
{
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
#pragma mark  tableViewDelegate  datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iden = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        
    }
    cell.bgcModel = _videoArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 221;
}
////获取数据
-(void)LoadData
{
    self.page=1;
    [self.videoArr removeAllObjects];
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)self.page]
                          };
     typeof(self) weakSelf = self;
        [self.manager POST:@"uploadFile/getVideo" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
            if ([responseObject[@"status"] boolValue] == true) {
                //NSMutableArray * arr = [[NSMutableArray alloc] init];
                weakSelf.videoArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
                 self.page = self.page +1;
                 [weakSelf.tableView.mj_header endRefreshing];

            }
            [weakSelf.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    
}
////加载更多
-(void)LoadMoreData
{
     NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                          };
     typeof(self) weakSelf = self;
     NSLog(@"%ld",(long)self.page);
     [self.manager POST:@"uploadFile/getVideo?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSMutableArray *mustArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
            if (mustArr.count == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.mj_footer endRefreshing];
                });
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.videoArr addObjectsFromArray:mustArr];
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                     self.page = self.page+1;
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
    ZFCustomControlViewViewController *vc = [[ZFCustomControlViewViewController alloc] init];
     vc.model = _videoArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
