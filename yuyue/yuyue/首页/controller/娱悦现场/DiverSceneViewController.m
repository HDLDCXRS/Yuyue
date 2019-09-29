//
//  DiverSceneViewController.m
//  yuyue
//
//  Created by edz on 2019/9/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DiverSceneViewController.h"
#import "DiverSceneViewTableViewCell.h"
#import"DiverSceneModel.h"
#import "NSString+Size.h"
#import "DetailSceneTableViewController.h" //现场详情
@interface DiverSceneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  * aTableView;

@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@end

@implementation DiverSceneViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];

    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"娱悦现场";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = [UIColor whiteColor];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.manager GET:@"homePage/getSite" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"返回成功！！"]) {
            NSArray *arr = [NSArray yy_modelArrayWithClass:[DiverSceneModel class] json:responseObject[@"result"]];
            self.mustableArray = arr;
            NSLog(@"%lu",(unsigned long)self.mustableArray.count);
            [self initMethod];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)initMethod
{
    _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _aTableView.delegate = self;
    _aTableView.dataSource = self;
    [self.view addSubview:_aTableView];
    [_aTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(SCREENHEIGHT);
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    DiverSceneViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DiverSceneViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
   //[cell setModel:
    cell.model = self.mustableArray[indexPath.row];
   // cell.timeLabel =self.mustableArray[indexPath.row];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)self.mustableArray.count);
    return  self.mustableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiverSceneModel *model = _mustableArray[indexPath.row];
    CGFloat min_h = [model.title textSizeWithFont:[UIFont fontWithName:@"PingFang SC" size: 14] limitWidth:139].height;
    return 250 + min_h;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailSceneTableViewController *vc = [[DetailSceneTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
