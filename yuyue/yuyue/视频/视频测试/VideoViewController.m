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
@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) NSInteger   page;
@property(nonatomic,strong) NSMutableArray  *videoArr;

@end

@implementation VideoViewController
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
    _tableView = [[UITableView alloc] init];
    _videoArr = [NSMutableArray arrayWithCapacity:4];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT-NavBar_Height);
    }];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _page = 1;
    [self LoadData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
}
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
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
//}
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
            
        }];

}
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
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            else
            {
            [weakSelf.videoArr addObjectsFromArray:mustArr];
           // weakSelf.videoArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
            //NSLog(@"%lu",(unsigned long)arr.count);
            [weakSelf.tableView reloadData];
            //[weakSelf.tableView.mj_footer endRefreshing];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
