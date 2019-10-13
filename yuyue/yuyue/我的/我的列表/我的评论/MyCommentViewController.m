//
//  MyCommentViewController.m
//  yuyue
//
//  Created by edz on 2019/9/24.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommontView.h"
#import "MyCommentModel.h"
@interface MyCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView   *tableView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSMutableArray  *numberArray;
@property(nonatomic,strong) MyCommentModel  *myModel;

@end

@implementation MyCommentViewController

-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        //
        [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@",TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _numberArray = [NSMutableArray arrayWithCapacity:1];
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
    [self.manager POST:@"myController/myComments" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"返回成功"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.numberArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[MyCommentModel class] json:responseObject[@"result"]];
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            });
            
            
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
    MyCommontView *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MyCommontView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    MyCommentModel *model = _numberArray[indexPath.row];
    cell.getMoneyLabel.text = model.userName;
    cell.timeLabel.text = model.createTime;
    cell.titleLabel.text = model.text;
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
         _myModel = _numberArray[indexPath.row];
     
        [self deletePostUrl];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.numberArray removeObjectAtIndex:indexPath.row];
        [tableView endUpdates];
    }
}
-(void)deletePostUrl
{
    NSDictionary *dic = @{
                          @"id":self.myModel.ida,
                          @"videoId":self.myModel.videoId,
                          @"authorId":self.myModel.userId
                          };
    NSLog(@"%@",dic);
    [self.manager POST:@"userComment/deleteComment?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] intValue] == 1) {
            NSLog(@"====");
           
        }
        else
        {
            NSLog(@"----");
             NSLog(@"%@",responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
