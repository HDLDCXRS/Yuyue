//
//  PerformanceTableViewController.m
//  yuYue
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "PerformanceTableViewController.h"
#import "PerformanceTableViewCell.h"
#import "UploadIdCardViewController.h"
#import "ShowPickerView.h"
#import "AddressBouncedView.h"  //地址弹框View
@interface PerformanceTableViewController ()<UITableViewDelegate,UITableViewDataSource,ShowPickerViewDelegate>
@property(nonatomic,strong) UITableView  *atabView;
@property(nonatomic,strong) NSArray  * mustFillArray;
@property(nonatomic,strong) NSArray  * selectArray;
@property(nonatomic,strong) UIButton  * commitBtn;
@property(nonatomic,strong) NSArray  *inputArray;
@property(nonatomic,strong) NSIndexPath  *indexPath;
@property(nonatomic,strong) NSMutableDictionary  *dic;
@property(nonatomic,strong) AddressBouncedView  * addressView;
@end

@implementation PerformanceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"申请演出";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _atabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _atabView.delegate =self ;
    _atabView.dataSource = self;
    [self.view addSubview:_atabView];
    _atabView.backgroundColor = [UIColor whiteColor];
    [_atabView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.bottom.equalTo(-85);
    }];
    _mustFillArray = @[@"姓名/乐队",@"人数",@"现住址",@"上传身份证",@"表演分类",@"节目名称",@"手机号码",@"上传影像"];
    _selectArray  = @[@"邮箱",@"微信"];
    _inputArray = @[@"请输入姓名",@"输入人数",@"请输入节目名称",@"请输入手机号码",@"请输入邮箱",@"请输入微信"];
    self.atabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _commitBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"矩形 1 拷贝 2"] setTitle:@"提交" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 17];
    [self.view addSubview:_commitBtn];
    [_commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-9);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(45);
    }];
    _addressView = [[AddressBouncedView alloc] init];
    _addressView.backgroundColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_addressView];
    [_addressView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(156);
        make.height.equalTo(190);
        make.left.equalTo(50);
        make.right.equalTo(-50);
    }];
    [_addressView.detailField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    _addressView.hidden = YES;
    _dic = [[NSMutableDictionary alloc] init];
}
-(void)commit
{
    NSLog(@"+++++");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _mustFillArray.count;
    }
    else
        return  2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row ==1 || indexPath.row ==5 || indexPath.row == 6  || indexPath.row == 4 ) {
            PerformanceTableViewCell *cell = [[PerformanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell.inputTextField addTarget:self action:@selector((textFieldEditChanged:)) forControlEvents:UIControlEventEditingChanged];
            cell.titleLabel.text = _mustFillArray[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.inputTextField.placeholder = _inputArray[0];
                    break;
                case 1:
                    cell.inputTextField.placeholder = _inputArray[1];
                    break;
                case 5:
                    cell.inputTextField.placeholder = _inputArray[2];
                    break;
                case 4:
                    cell.inputTextField.placeholder = @"请输入分类名称";
                    break;
                case 6:
                    cell.inputTextField.placeholder = _inputArray[3];
                    break;
                default:
                    break;
            }
            return cell;
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
            cell.textLabel.textColor = RGBA(51, 51, 51, 1);
            cell.textLabel.text = _mustFillArray[indexPath.row];
            
            return cell;
        }
    }
    else
    {
        PerformanceTableViewCell *cell = [[PerformanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.titleLabel.text = _selectArray[indexPath.row];
        [cell.inputTextField addTarget:self action:@selector((textFieldEditChanged:)) forControlEvents:UIControlEventEditingChanged];
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.placeholder = _inputArray[4];
                break;
            case 1:
                cell.inputTextField.placeholder = _inputArray[5];
                break;
            default:
                break;
        }
        return cell;
       
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = nil;
    header = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH,38)];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, 38)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    lab.textColor = RGBA(153, 153, 153, 1);
    [header addSubview:lab];
    [lab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.centerY);
        make.right.equalTo(0);
        make.left.equalTo(15);
        make.height.equalTo(14);
    }];
    header.backgroundColor = RGBA(243, 243, 243, 1);
    
    if (section == 0) {
        lab.text = @"必填内容";
    }
    else
    {
        lab.text = @"选填内容";
    }
    [header layoutIfNeeded];
    
    return header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = nil;
    if (section == 1) {
        footer = [[UIView alloc]initWithFrame:CGRectMake(15,0, SCREENWIDTH,108)];
        UIImageView *bgcImg = [[UIImageView alloc] init];
        bgcImg.image = [UIImage imageNamed:@"问题 (1)"];
        CGSize size = bgcImg.image.size;
        [footer addSubview:bgcImg];
        [bgcImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(size.width, size.height));
        }];
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectZero];
                lab.textAlignment = NSTextAlignmentLeft;
                lab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 12];
                lab.numberOfLines = 0;
                lab.text = @"请确认填写信息真实，如有违法违规行为信息将作为有关部门证据";
                lab.textColor = RGBA(153, 153, 153, 1);
                [footer addSubview:lab];
                [lab makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(footer.centerY);
                    make.right.equalTo(-15);
                    make.left.equalTo(15);
                    make.height.equalTo(60);
                }];

        footer.backgroundColor = RGBA(243, 243, 243, 1);
    }
    
    return footer;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    else
        return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)textFieldEditChanged:(UITextField *)textField
{
    if (_indexPath.section == 0) {
        switch (_indexPath.row) {
            case 0:
                [_dic setValue:textField.text forKey:@"teamName"];
                break;
            case 1:
                 [_dic setValue:textField.text forKey:@"size"];
                break;
            case 4:
                [_dic setValue:textField.text forKey:@"categoryId"];
                break;
            case 5:
                 [_dic setValue:textField.text forKey:@"description"];
                break;
            case 6:
                [_dic setValue:textField.text forKey:@"phone"];
                break;
            default:
                break;
        }
    }
    else
    {
        if (_indexPath.section == 1) {
            switch (_indexPath.row) {
                case 0:
                    [_dic setValue:textField.text forKey:@"mail"];
                    break;
                case 1:
                    [_dic setValue:textField.text forKey:@"status"];
                    break;
                default:
                    break;
            }
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row ==3) {
        UploadIdCardViewController *VC= [[UploadIdCardViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row ==4) {
        UploadIdCardViewController *VC= [[UploadIdCardViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}
- (void)showPickerViewDone:(NSString *)chooseTitle chooseId:(NSString *)chooseId
{
    
    [_dic setValue:chooseTitle forKey:@"site"];
}
@end
