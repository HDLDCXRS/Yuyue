//
//  DetailVideoViewController.m
//  yuyue
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "DetailVideoViewController.h"
#import "CustomSearchView.h"
#import "VideoCell.h"
#import "VideoModel.h"
@interface DetailVideoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) CustomSearchView  *searchView;
@property(nonatomic,strong) UISearchBar  *searchBar;
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSMutableArray  *videoArr;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,assign) NSInteger   page;
@end
@implementation DetailVideoViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        //
        //[_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSearchBarView];
    [self initWithTableView];
}
-(void)initSearchBarView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREENWIDTH-100,32)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 100, 32)];
    self.searchBar.placeholder = @"搜明星、演出";
    self.searchBar.text = _searchStr;
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的主题颜色
    //设置背景色
    self.searchBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
    // 修改cancel
    self.searchBar.showsCancelButton= NO;
    self.searchBar.barStyle=UIBarStyleDefault;
    self.searchBar.delegate=self;
    // 修改cancel
    self.searchBar.showsSearchResultsButton=NO;
    //5. 设置搜索Icon
    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
     searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
    //一下代码为修改placeholder字体的颜色和大小
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    //2. 设置圆角和边框颜色
    if(searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        [searchField setValue:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    }
    // 输入文本颜色
    searchField.textColor= [UIColor blackColor];
    searchField.font= [UIFont systemFontOfSize:15];
    // 默认文本大小
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
}
-(void)initWithTableView
{
    _tableView = [[UITableView alloc] init];
    _videoArr = [NSMutableArray arrayWithCapacity:1];
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
     [self SearchLoadData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(SearchLoadData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
    [self.tableView.mj_footer beginRefreshing];
   
    
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
-(void)SearchLoadData
{
    if (self.searchBar.text.length == 0) {
        NSLog(@"没有数据");
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }
    else
    {
        self.page= 1;
        [self.videoArr removeAllObjects];
        NSDictionary *dic = @{
                              @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                              @"content":self.searchBar.text
                              };
        typeof(self) weakSelf = self;
        [self.manager POST:@"uploadFile/getVideo?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"status"] boolValue] == true) {
                weakSelf.videoArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_header endRefreshing];
            }
            else
            {
                NSLog(@"++++");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
            NSLog(@"%@",error);
        }];
    }
}
-(void)LoadMoreData
{
    if (self.searchBar.text.length == 0) {
        NSLog(@"没有数据");
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }
    else
    {
    self.page = self.page +1;
    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                          @"content":self.searchBar.text
                          };
    typeof(self) weakSelf = self;
    NSLog(@"%ld",(long)self.page);
    [self.manager POST:@"uploadFile/getVideo?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSMutableArray *mustArr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[VideoModel class] json:responseObject[@"result"]];
            if (mustArr.count == 0) {
                self.page =self.page -1;
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_searchBar isExclusiveTouch]) {
        [_searchBar resignFirstResponder];
    }
    NSLog(@"++++++");
}
#pragma uisearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
     [_videoArr removeAllObjects];
     [self SearchLoadData];
     //[_tableView reloadData];
}
//点击空白地方退出
//退出键盘之后退出
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_searchBar isExclusiveTouch]) {
       [_searchBar resignFirstResponder];
    }
}

@end
