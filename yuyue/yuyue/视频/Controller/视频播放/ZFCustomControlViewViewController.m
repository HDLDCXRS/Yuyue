//
//  ZFCustomControlViewViewController.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2019/6/5.
//  Copyright © 2019 紫枫. All rights reserved.
//

#import "ZFCustomControlViewViewController.h"
#import "ZFCustomControlView1.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/KSMediaPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "BanKuanView.h"
#import "HostStyleViewController.h" //跳转爆款
#import "CommentTableViewCell.h"
#import "WriteCommentView.h"
#import "GetAllCommentModel.h"

@interface ZFCustomControlViewViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFCustomControlView1 *controlView;
@property(nonatomic,strong) NSString  *kVideoCover;
@property(nonatomic,strong) BanKuanView  *baoKuanView; //爆款
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSMutableArray  *dicArr;
@property(nonatomic,strong) WriteCommentView  *bottomView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) NSInteger  page;
@end

@implementation ZFCustomControlViewViewController
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
    [self playerView];
    _bottomView = [[WriteCommentView alloc] init];
    [self.view addSubview:_bottomView];
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    [_bottomView.commentField.textSearchField addTarget:self action:@selector(textFinished:) forControlEvents:UIControlEventEditingDidEnd];
    _tableView = [[UITableView alloc] init];
    _dicArr = [[NSMutableArray alloc] initWithCapacity:3];;
    //[_dicArr addObject:@"1"];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baoKuanView.bottom).offset(17);
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.bottomView.top).offset(0);
    }];
   
    _tableView.delegate =self;
    _tableView.dataSource = self;
     typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         weakSelf.page = 1;
        [weakSelf.dicArr removeAllObjects];
        [weakSelf.tableView.mj_header beginRefreshing];
        [weakSelf getAllComment];
    }];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getAllComment)];
    [self.tableView.mj_header beginRefreshing];
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getAllComment)];
    [self.tableView.mj_footer beginRefreshing];
    [footer setTitle:@"暂时没有更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"暂时没有更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    [self getAllComment];
    _tableView.mj_footer = footer;
    _tableView.tableFooterView = [UIView new];
   [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"cellID"];
}

#pragma tableViewDelegate
#pragma mark  tableViewDelegate  datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dicArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.model = _dicArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma  playerView
-(void)playerView
{
    _kVideoCover = [NSString stringWithFormat:@"%@",_model.videoAddress];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    [self.containerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(200);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ViewHashChange)
                                                 name:@"ViewHashChange"
                                               object:nil];
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        [self.player playTheNext];
        if (!self.player.isLastAssetURL) {
            //NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
            // [self.controlView showTitle:title coverURLString:self.kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    _baoKuanView = [[BanKuanView alloc] init];
    [_baoKuanView setModel:_model];
    [self.view addSubview:_baoKuanView];
    [_baoKuanView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.bottom).offset(0);
        make.left.right.equalTo(0);
        make.height.equalTo(71);
    }];
    typeof(self) weakSelf = self;
    _baoKuanView.baoKuanClick = ^(UIButton * _Nonnull btn) {
        HostStyleViewController *vc = [[HostStyleViewController alloc ] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    playerManager.assetURL = _model.filesPath;
    [self.controlView showTitle:_model.title coverURLString:_kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    self.controlView.ClickPop = ^(UIButton * _Nonnull btn) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
-(void)ViewHashChange
{
    NSLog(@"++++++");
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.player.viewControllerDisappear = NO;
     self.navigationController.navigationBarHidden = YES;
    self.page =1 ;
    [self getAllComment];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
     self.navigationController.navigationBarHidden = NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFCustomControlView1 *)controlView {
    if (!_controlView) {
        _controlView = [ZFCustomControlView1 new];
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:_kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma 获取所有评论
-(void)getAllComment
{
    typeof(self) weakSelf =self;
    NSDictionary *dic = @{
                          @"videoId":_model.videoId,
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page]
                          };
    [self.manager POST:@"userComment/getAllComment?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSMutableArray *newArr =(NSMutableArray *)[NSArray yy_modelArrayWithClass:[GetAllCommentModel class] json:responseObject[@"result"][@"comment"]];
            if ([responseObject[@"status"] boolValue] == true) {
                if (newArr.count == 0) {
                    [weakSelf.tableView.mj_header endRefreshing];
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
                else
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        weakSelf.page = weakSelf.page +1;
                        [weakSelf.dicArr addObjectsFromArray:newArr];
                        NSLog(@"%@",responseObject[@"message"]);
                        [weakSelf.tableView reloadData];
                        
                    });
                }
                
            }
        }
       
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma action 评论
-(void)textFinished:(UITextField*)textField
{
    if (textField.text.length ==0) {
        textField.placeholder = @"输入不能为空";
    }
    else
    {
        if (textField.text.length >20) {
            textField.text =nil;
          textField.placeholder = @"输入不能超过二十个字";
        }
        else
        {
            textField.placeholder = @"写评论";
            [self postCommentURL:textField];
        }
    }
}
-(void)postCommentURL:(UITextField *)textField
{
    NSDictionary *dicA = @{
                           @"videoId":_model.videoId,
                           @"authorId":_model.authorId,
                           @"text":textField.text
                           };
    NSLog(@"%@",_model.videoId);
    typeof(self) weakSelf = self;
    [self.manager POST:@"userComment/addComment" parameters:dicA progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSLog(@"%@----",responseObject[@"message"]);
            GetAllCommentModel *model = [[GetAllCommentModel alloc] init];
            model.text = textField.text;
            model.userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickName"];
            model.createTime =@"刚刚";
            model.headUrl = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"headerUrl"]];
            [weakSelf.dicArr addObject:model];
            NSLog(@"%@",responseObject[@"message"]);
            [weakSelf.tableView reloadData];
            [self scrollTableToFoot:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)scrollTableToFoot:(BOOL)animated {
    NSInteger s = [self.tableView numberOfSections];
    if (s<1) return;
    NSInteger r = [self.tableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}
@end
