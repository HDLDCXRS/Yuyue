//
//  FirstPageViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FirstPageViewController.h"
#import "MainADView.h"
#import "SpeedViewCell.h"
#import "SpeedModel.h"
#import "MainADModel.h"
#import <UIImageView+WebCache.h>
#import "GYZChooseCityController.h"
#import "DiverSceneViewController.h"
#import "SpeedView.h"
#import "CustomHeadView.h"
#import "ZFCustomControlViewViewController.h"//视频详情播放
#import "VideoCell.h"
static NSString *kIdentifier = @"kIdentifier";
@interface FirstPageViewController ()<GYZChooseCityDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIButton  * locationBtn;
@property(nonatomic,strong) UILabel  * loactionLabel;
@property(nonatomic,assign)  CGSize btnImageSize;
@property(nonatomic,strong) AFHTTPSessionManager  * manager;
@property(nonatomic,strong) NSMutableArray  * shuffingAry;
@property(nonatomic,strong) CustomHeadView  *headView;
@property(nonatomic,strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *videoArr;
@property(nonatomic,assign) NSInteger  page;

@end
@implementation FirstPageViewController
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
    [self loactionView];
   
    
}
-(void)loactionView
{
    _tableView = [[UITableView alloc ] init];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Status_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(SCREENHEIGHT-Status_Height-TabBar_Height);
    }];
    [_tableView layoutIfNeeded];
    [_tableView registerClass:[VideoCell class] forCellReuseIdentifier:kIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage imageNamed:@"回到顶部"] forState:UIControlStateNormal];
    CGSize size = btn.currentImage.size;
    [self.view addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-TabBar_Height-69);
        make.right.equalTo(-19);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    [btn addTarget:self action:@selector(toTopViewMethod) forControlEvents:UIControlEventTouchUpInside];
    self.headView = [[CustomHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 368)];
    _tableView.tableHeaderView = self.headView;
    [_headView.locationBtn addTarget:self action:@selector(locationMethod) forControlEvents:UIControlEventTouchUpInside];
    [self requireData];
    //点击分类进行跳转
    typeof(self) weakSelf = self;
    self.headView.speedView.clickBlock =^(NSInteger index) {
        switch (index) {
            case 0:
            {
                DiverSceneViewController *vc = [[DiverSceneViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
            }
                break;
            case 5:
            {
                
            }
                break;
            case 6:
            {
                
            }
                break;
            default:
                break;
        }
   };
   
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
    self.tableView.mj_footer = footer;
}
-(void)requireData
{
    typeof(self) weakSelf = self;
    [self.manager GET:@"homePage/result" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"返回轮播图和节目表演成功！"]) {
            NSLog(@"请求成功");
            NSArray *mainArray = [NSArray yy_modelArrayWithClass:[MainADModel class] json:responseObject[@"result"][@"banners"]];
            NSArray *speedArray = [NSArray yy_modelArrayWithClass:[SpeedModel class] json:responseObject[@"result"][@"categories"]];
            weakSelf.headView.speedView.dataSourse = speedArray;
            weakSelf.headView.mainADView.dataSourse = mainArray;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败+++");
        NSLog(@"%@",error);
    }];
}
//回到顶部
-(void)toTopViewMethod
{
   [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
-(void)locationMethod
{
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self.navigationController pushViewController:cityPickerVC animated:YES];
}
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    _loactionLabel.text = city.cityName;
    [chooseCityController.navigationController popViewControllerAnimated:YES];
}
- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
     [chooseCityController.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    [self.manager POST:@"homePage/getVideoToHomePage" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
    [self.manager POST:@"homePage/getVideoToHomePage?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
