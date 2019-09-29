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

//视频
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/KSMediaPlayerManager.h>
#import "ZFPlayerDetailViewController.h"
#import "VideoTableViewCell.h"
#import "HDLTableData.h"
static NSString *kIdentifier = @"kIdentifier";
@interface FirstPageViewController ()<GYZChooseCityDelegate,UITableViewDelegate,UITableViewDataSource,VideoTableViewCellDelegate>
@property(nonatomic,strong) UIButton  * locationBtn;
@property(nonatomic,strong) UILabel  * loactionLabel;
@property(nonatomic,assign)  CGSize btnImageSize;
@property(nonatomic,strong) AFHTTPSessionManager  * manager;
@property(nonatomic,strong) NSMutableArray  * shuffingAry;
@property(nonatomic,strong) CustomHeadView  *headView;
@property(nonatomic,strong) UITableView  *tableView;
//
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
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
    [self requestData];

    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
  
    
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:100];
    self.player.controlView = self.controlView;
    self.player.assetURLs = self.urls;
    self.player.shouldAutoPlay = NO; //设置是否自动播放
    /// 1.0是完全消失的时候
    self.player.playerDisapperaPercent = 1.0; //当前播放器滚动超出屏幕 消失
    
    @weakify(self) //orientationWillChange 当方向改变的时候
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate]; //让动画一起改变
        [UIViewController attemptRotationToDeviceOrientation]; //当前接口方向与设备部匹配可能发生旋转
        self.tableView.scrollsToTop = !isFullScreen;
    };
    
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        //        if (self.player.playingIndexPath.row < self.urls.count - 1 && !self.player.isFullScreen) {
        //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.player.playingIndexPath.row+1 inSection:0];
        //            [self playTheVideoAtIndexPath:indexPath scrollToTop:YES];
        //        } else if (self.player.isFullScreen) {
        [self.player stopCurrentPlayingCell];
        //        }
    };
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
    [_tableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:kIdentifier];
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
   
    // 设置回调（一旦进入刷新状态，就调用 target 的 action，也就是调用 self 的 loadNewData 方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)loadNewData
{
//    [UIView animateWithDuration:5 animations:^{
//        [self.tableView.mj_header endRefreshing];
//    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    
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
- (void)requestData {
    self.urls = @[].mutableCopy;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.dataSource = @[].mutableCopy;
    NSArray *videoList = [rootDict objectForKey:@"list"];
    for (NSDictionary *dataDic in videoList) {
        HDLTableData *data = [[HDLTableData alloc] init];
        [data setValuesForKeysWithDictionary:dataDic];
        HDLTableViewCellLayout *layout = [[HDLTableViewCellLayout alloc] initWithData:data];
        [self.dataSource addObject:layout];
        NSString *URLString = [data.video_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:URLString];
        [self.urls addObject:url];
    }
}

- (BOOL)shouldAutorotate {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden; //隐藏状态栏
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate 列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDelegate:self withIndexPath:indexPath];
    cell.layout = self.dataSource[indexPath.row];
    [cell setNormalMode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 如果正在播放的index和当前点击的index不同，则停止当前播放的index
    if (self.player.playingIndexPath != indexPath) {
        [self.player stopCurrentPlayingCell];
    }
    /// 如果没有播放，则点击进详情页会自动播放
    if (!self.player.currentPlayerManager.isPlaying) {
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }
    /// 到详情页
    ZFPlayerDetailViewController *detailVC = [ZFPlayerDetailViewController new];
    detailVC.player = self.player;
    @weakify(self)
    /// 详情页返回的回调
    detailVC.detailVCPopCallback = ^{
        @strongify(self)
        if (self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlayStopped) {
            [self.player stopCurrentPlayingCell];
        } else {
            [self.player addPlayerViewToCell];
        }
    };
    /// 详情页点击播放的回调
    detailVC.detailVCPlayCallback = ^{
        @strongify(self)
        [self hdl_playTheVideoAtIndexPath:indexPath];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDLTableViewCellLayout *layout = self.dataSource[indexPath.row];
    return layout.height;
}

#pragma mark - ZFTableViewCellDelegate

- (void)hdl_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

#pragma mark - private method

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    HDLTableViewCellLayout *layout = self.dataSource[indexPath.row];
    [self.controlView showTitle:nil
                 coverURLString:layout.data.thumbnail_url
                 fullScreenMode:layout.isVerticalVideo?ZFFullScreenModePortrait:ZFFullScreenModeLandscape];
}

#pragma mark - getter
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//}


@end
