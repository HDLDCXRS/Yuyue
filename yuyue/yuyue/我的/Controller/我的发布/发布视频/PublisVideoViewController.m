//
//  PublisVideoViewController.m
//  yuyue
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PublisVideoViewController.h"
#import "PublisVideoView.h"
#import "PublisjTableViewCell.h"
@interface PublisVideoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong) UITableView  *aTableView;
@property(nonatomic,strong) PublisVideoView  *publisView;
@property(nonatomic,strong) NSArray  *titleArry;
@property(nonatomic,strong) PublisjTableViewCell  *notictCell;
@end

@implementation PublisVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.navigationItem.title =@"发布视频";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [self initNavagation];
    _publisView = [[PublisVideoView alloc] init];
    [self.view addSubview:_publisView];
    [_publisView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(212);
    }];
    _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_aTableView];
    [_aTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publisView.bottom).offset(10);
        make.right.left.equalTo(0);
        make.height.equalTo(120);
    }];
    _aTableView.delegate = self;
    _aTableView.dataSource = self;
    _titleArry = @[@"请输入标题",@"请输入原创姓名",@"作品分类"];
    _aTableView.tableFooterView = [UIView new];
    self.aTableView.scrollEnabled =NO;
    _publisView.onClickBtn = ^(UIButton * _Nonnull btn) {
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID=@"cellID";
   PublisjTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[PublisjTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.row ==2) {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.titleTextField.placeholder = _titleArry[indexPath.row];
    cell.titleTextField.tag = indexPath.row;
    [cell.titleTextField addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventEditingChanged];
    return cell;
}
-(void)initNavagation
{
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton  *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,36, 16,16)];
    [rightBtn setImage:[UIImage imageNamed:@"发布箭头"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)rightBtnClick
{
//    switch (textField.tag) {
//        case 0:
//              NSLog(@"%@",textField.text);
//            break;
//        case 1:
//             NSLog(@"%@",textField.text);
//            break;
//        case 2:
//            NSLog(@"%@",textField.text);
//            break;
//        default:
//            break;
//    }
}
@end
