//
//  SetUpTableViewController.m
//  yuYue
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "SetUpTableViewController.h"
#import "BaseViewController.h"
#import "ModifyPhoneViewController.h"
#import "ChangePasswordViewController.h"
#import "RealNameViewController.h"
#import "BindingAccountViewController.h"
@interface SetUpTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView  * SetUptableView;
@property(nonatomic,strong) NSArray  * titleArray;
@property(nonatomic,strong) NSArray  * headTitleArray;
@property(nonatomic,strong) UITableViewCell *cell;
@property(nonatomic,assign) NSInteger  section;
@end

@implementation SetUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTableView];
}
-(void)onClickMehod
{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];  
    [self.navigationController popViewControllerAnimated:YES];
}
//tableView的初始化
-(void)initWithTableView
{
    self.navigationItem.title =@"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _SetUptableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _SetUptableView.delegate =self;
    _SetUptableView.dataSource = self;
    [self.view addSubview:_SetUptableView];
    [_SetUptableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(0);
    }];
    _titleArray = @[@[@"基本信息",@"实名认证",@"绑定账号"],@[@"修改手机号",@"修改密码"],@[@"清除缓存",@"版本更新"]];
    _headTitleArray = @[@"个人设置",@"安全设置",@"系统设置"];
    self.SetUptableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.SetUptableView.scrollEnabled = NO;
    _exitBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"退出登录" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClickMehod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exitBtn];
    [_exitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(16);
        make.right.equalTo(-16);
        make.height.equalTo(44);
        make.bottom.equalTo(-25);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _headTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else
        return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID=@"cellID";
    _cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (_cell==nil) {
        _cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    _cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    _cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 15];
    _cell.textLabel.textColor = RGBA(51, 51, 51, 1);
    //不显示点击后背景变色
    _cell.selectionStyle = UITableViewCellAccessoryNone;
    _cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
 
    if (indexPath.section == 2 &&indexPath.row == 0) {
        _cell.detailTextLabel.text = @"46.22MB";
        _cell.detailTextLabel.font =  [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _cell.detailTextLabel.textColor = RGBA(102, 102, 102, 1);
        _cell.accessoryType= UITableViewCellAccessoryNone;
    }
    else if(indexPath.section == 2 &&indexPath.row ==1)
    {
        _cell.detailTextLabel.font =  [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _cell.detailTextLabel.text = @"v1.0";
        _cell.detailTextLabel.textColor = RGBA(102, 102, 102, 1);
    }
    return self.cell;
}

 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,32)];
     UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15,0, SCREENWIDTH, 32)];
     lab.text = [NSString stringWithFormat:@"%@",_headTitleArray[section]];
     lab.textAlignment = NSTextAlignmentLeft;
     lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
     lab.textColor = RGBA(153, 153, 153, 1);
     [header addSubview:lab];
     header.backgroundColor = RGBA(243, 243, 243, 1);
     return header;
 }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}
//设置为0
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        BaseViewController *vc = [[BaseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        RealNameViewController *vc = [[RealNameViewController alloc] init];
       [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 2)
    {
        BindingAccountViewController *vc = [[BindingAccountViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        ModifyPhoneViewController *vc = [[ModifyPhoneViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
