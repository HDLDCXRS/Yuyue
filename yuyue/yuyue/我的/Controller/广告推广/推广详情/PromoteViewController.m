//
//  PromoteViewController.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PromoteViewController.h"

@interface PromoteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIImageView  *imgView;
@property(nonatomic,strong) UITableView  *aTablView;
@property(nonatomic,strong) UIButton  *payBtn;
@property(nonatomic,strong) NSArray  *titleArray;
@end

@implementation PromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"推广详情";
    //设置背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = [UIColor whiteColor];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREENWIDTH, 10)];
    _imgView.backgroundColor = RGBA(243, 243, 243, 1);
    [self.view addSubview:_imgView];
    _payBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"支付广告费" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(payMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    [_payBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-18);
        make.left.equalTo(15);
        make.right.equalTo(15);
        make.height.equalTo(45);
    }];
    _aTablView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _aTablView.delegate = self;
    _aTablView.dataSource = self;
    [self.view addSubview:_aTablView];
    [_aTablView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.bottom).offset(0);
        make.left.equalTo(0);
        make.bottom.equalTo(self.payBtn.top).offset(0);
        make.right.equalTo(0);
    }];
    //去掉多余的cell
     self.aTablView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _titleArray = @[@"分类",@"商品名称",@"广告词",@"上传影像",@"商品价格",@"购买链接",@"地址"];
}
-(void)payMethod
{
    NSLog(@"++++++++");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell  =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    cell.textLabel.textColor =RGBA(51, 51, 51, 1);
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}
@end
