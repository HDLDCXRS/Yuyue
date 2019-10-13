//
//  MineViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "TableViewCell.h"
#import "HBK_ScanViewController.h"
#import "MineMoneyViewController.h"
#import "MainLoginViewController.h" //登录
#import "SetUpTableViewController.h"
#import "AdvertistingViewController.h"
#import "PerformanceTableViewController.h"  //演出申请
#import "MinePublishViewController.h"//我的发布
#import "AboutOurViewController.h" //
#import "GiftViewController.h"  //礼物明细
#import "MyAdvertiserViewController.h"  //我的广告
#import "LoginModel.h"
#import "MyCommentViewController.h"  //我的评论
//意见反馈
#import "FeedBackViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UITableView  * aTableView;
@property(nonatomic,strong) NSArray  * imgArray;
@property(nonatomic,strong) NSArray  * titleArray;
@property(nonatomic,strong) TableViewCell *cell;
@property(nonatomic,strong)  MineHeadView *mine;
@property(nonatomic,strong)  MineMoneyViewController *mineMoneyController;
@property(nonatomic,strong) UIScrollView  *scrollView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) UIRefreshControl  *refreshControl;
@property(nonatomic,strong) LoginModel *model ;

@end

@implementation MineViewController
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
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(-TabBar_Height);
    }];
    _scrollView.delegate = self;
    _scrollView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT-NavBar_Height-TabBar_Height);
    _titleArray = @[@"我的评论",@"爆款广告推广",@"艺人合作申请",@"帮助与反馈",@"关于我们"];
    _imgArray= @[@"评论",@"广告推广",@"演出申请",@"帮助与反馈",@"关于我们"];
    _mine = [[MineHeadView alloc] init];
    int index = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] intValue] ;
    NSLog(@"%d",index);
    [_mine switchIndex:index];
    [_scrollView addSubview:_mine];
    [_mine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(320);
    }];
    typeof(self) weakSelf = self;
    _mine.btnClick = ^(NSInteger index) {
        switch (index) {
            case 1:
            {
                MainLoginViewController *vc = [[MainLoginViewController alloc] init];
                {
                    vc.returnValueBlock = ^(LoginModel * _Nonnull passedValue) {
                         [weakSelf.mine setModel:passedValue];
                    };
                }
                [weakSelf.navigationController pushViewController:vc animated:YES];
            
            }
                break;
            case 2:
            {
                SetUpTableViewController *vc = [[SetUpTableViewController alloc] init];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 3:
            {
                HBK_ScanViewController *vc = [[HBK_ScanViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                MineMoneyViewController *vc = [[MineMoneyViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                MinePublishViewController *vc = [[MinePublishViewController alloc] init];
        
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:
            {
                MyAdvertiserViewController *vc = [[ MyAdvertiserViewController alloc] init];

                [weakSelf.navigationController pushViewController:vc animated:YES];
//                NSLog(@"+++");
            }
                break;
            default:
                break;
        }
    };
    _mine.artView.clickBtn = ^(UIButton *btn) {
        GiftViewController *vc = [[GiftViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self initTableView];
  
}
-(void)initTableView
{
    //设置背景线
    UIView *lineView = [[UIView alloc] init];
    [_scrollView addSubview:lineView];
    lineView.backgroundColor = RGBA(243, 243, 243, 1);
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mine.bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.offset(10);
    }];
    _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_scrollView addSubview:_aTableView];
    [_aTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
    }];
   // [_aTableView layoutIfNeeded];
    _aTableView.delegate = self;
    _aTableView.dataSource = self;
    _aTableView.tableFooterView = [UIView new];
    _aTableView.backgroundColor = RGBA(243, 243, 243, 1);
    self.aTableView.scrollEnabled =NO;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
     _cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!_cell) {
     _cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       
    }
    _cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    _cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    _cell.titleLabel.text = self.titleArray[indexPath.row];
   
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return _cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.imgArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if([_model.userStatus isEqualToString:@"10B"] || [_model.userStatus isEqualToString:@"10C"] || [_model.userStatus isEqualToString:@"10D"])
    {
        switch (indexPath.row) {
            case 0:
            {
                MyCommentViewController *vc = [[MyCommentViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                if ([_model.userStatus isEqualToString:@"10C"] || [_model.userStatus isEqualToString:@"10B"]) {
                    AdvertistingViewController *adverVC = [[ AdvertistingViewController alloc] init];
                    [self.navigationController pushViewController:adverVC animated:YES];
                }
                else
                {
                    
                }
            }
                break;
            case 2:
            {
                PerformanceTableViewController *perFormanceVC = [[PerformanceTableViewController alloc] init];
                [self.navigationController pushViewController:perFormanceVC animated:YES];
            }
                break;
            case 3:
            {
                FeedBackViewController *vc = [[FeedBackViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                AboutOurViewController *vc = [[AboutOurViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        [self logout];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    int index = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] intValue] ;
    NSLog(@"%d",index);
    [_mine switchIndex:index];
    [self headRefresh];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void) logout {
    // 初始化对话框
    typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
    // 确定注销
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        MainLoginViewController *vc = [[MainLoginViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
- (void)headRefresh{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] ) {
        typeof(self) weakSelf =self;
        [self.manager POST:@"login/getMessage" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"message"] isEqualToString:@"获取成功！"]) {
                LoginModel *model = [LoginModel yy_modelWithDictionary:responseObject[@"result"]];
                weakSelf.model = model;
                 [weakSelf.mine setModel:model];
               
               
                //NSLog(@"%@",model.opendId);
                 [[NSUserDefaults standardUserDefaults] setValue:model.opendId forKey:@"opendId"];
                NSLog(@"%@",model.opendId);
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"opendId"]);
                 [weakSelf getData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
    }
 
    
}
-(void)getData
{

    [self.scrollView.mj_header endRefreshing];
}
//
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    decelerate = YES;
    if (scrollView.contentOffset.y < 20) {
        [scrollView.mj_header beginRefreshing];
    }
}



@end
