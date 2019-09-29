//
//  BaseViewController.m
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"
#import "BassInformationTableViewCell.h"
#import "CustomerModel.h"
#import "BaseCommonTableViewCell.h"
#import "SexPickerTool.h"
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong) BaseView  * baseView;
@property(nonatomic,strong) UITableView  * aTableView;
@property(nonatomic,strong) BassInformationTableViewCell  * cell;
@property(nonatomic,strong) NSArray  * titleArray;
@property(nonatomic,strong) NSArray  * contentArray;
@property(nonatomic,strong) NSIndexPath  *index;
//@property(nonatomic,strong) UIPickerView  *pickerView;
//@property(nonatomic,strong) NSArray  *dataSource;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithHeadImageMethod];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}

//基本信息头像
-(void)initWithHeadImageMethod
{
    self.navigationItem.title =@"基本信息";
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    _baseView = [[BaseView alloc] init];
    [self.view addSubview:_baseView];
    [_baseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(150);
    }];
    //列表昵称等
    _aTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_aTableView];
    [_aTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.bottom).offset(10);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(SCREENHEIGHT-NavBar_Height-10-self.baseView.frame.size.height);
    }];
    _titleArray = @[@"昵称",@"性别",@"微信",@"学历",@"个人墙"];
    _contentArray = @[@"请设置昵称",@"请选择您的性别",@"请填写微信号",@"请选择",@"请输入"];
    _aTableView.delegate =self;
    _aTableView.dataSource = self;
    _aTableView.tableFooterView = [UIView new];
    [_aTableView registerClass:[BaseCommonTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_aTableView registerClass:[BassInformationTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.aTableView.scrollEnabled =NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
        BassInformationTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
      
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titlleLabel.text = _titleArray[indexPath.row];
        cell.inputTextField.placeholder = _contentArray[indexPath.row];
        return cell;
    }
   else
   {
       BaseCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
       cell.titlleLabel.text = _titleArray[indexPath.row];
       cell.inputTextField.text = _contentArray[indexPath.row];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
   }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"%ld",indexPath.row);
            break;
        case 1:
            [self sexMethod];
            break;
        case 2:
             NSLog(@"%ld",indexPath.row);
            break;
        default:
            break;
    }
}
-(void)sexMethod
{
    SexPickerTool *sexPick = [[SexPickerTool alloc] initWithFrame:CGRectMake(0,SCREENHEIGHT-200, self.view.frame.size.width, 200)];
    __block SexPickerTool *blockPicker = sexPick;
    sexPick.callBlock = ^(NSString *pickDate) {
        NSLog(@"%@",pickDate);
        
        if (pickDate) {
            
        }
        
        [blockPicker removeFromSuperview];
    };
    [self.view addSubview:sexPick];
    
}
@end
