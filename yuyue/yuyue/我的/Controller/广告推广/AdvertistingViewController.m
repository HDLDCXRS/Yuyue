//
//  AdvertistingViewController.m
//  yuyue
//
//  Created by edz on 2019/8/26.
//  Copyright © 2019 edz. All rights reserved.
//

#import "AdvertistingViewController.h"
#import "BusinessLicenseViewController.h"
#import "UploadIdCardViewController.h"
#import "PromoteViewController.h"
#import "PhomeNumberViewController.h"
#import "NSString+Size.h"
#import "AddressBouncedView.h"
#import "ShowPickerView.h"
@interface AdvertistingViewController ()<UITableViewDataSource,UITableViewDelegate,ShowPickerViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITableView  * adverjistTableView;
@property(nonatomic,strong) NSArray  * titleArrayOne;
@property(nonatomic,strong) NSArray  * titleArrayTwo;
@property(nonatomic,strong) AddressBouncedView  *addressView;
@property(nonatomic,strong) NSMutableDictionary  *dic;

@end

@implementation AdvertistingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"广告推广";
   _dic = [[NSMutableDictionary alloc]init];
    //设置背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    [self initWithTableView];
    _commitBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"矩形 1 拷贝 2"] setTitle:@"提交" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(commitMethod) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size: 17];
    [self.view addSubview:_commitBtn];
    [_commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-14);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(45);
    }];
 
    
}
-(void)commitMethod
{
    PromoteViewController *VC=  [[PromoteViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
//tableView的布局
-(void)initWithTableView
{
    _adverjistTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_adverjistTableView];
    [_adverjistTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getRectNavAndStatusHight);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(-85);
    }];
    _adverjistTableView.delegate = self;
    _adverjistTableView.dataSource =self;
    
    [self.view addSubview:_adverjistTableView];
    _titleArrayOne = @[@"商家地址",@"营业执照/资质",@"法人身份",@"机构代码",@"商家名称",@"手机号码"];
    _titleArrayTwo = @[@"产地",@"固定号码",@"邮箱",@"微信",@"QQ",@"商品链接",@"联系电话"];
    _adverjistTableView.bounces = NO;
    self.adverjistTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    else
        return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
    cell.textLabel.textColor = RGBA(51, 51, 51, 1);
    if (indexPath.section == 0) {
        cell.textLabel.text = _titleArrayOne[indexPath.row];
       if(indexPath.row == 0)
       {
           if (![_dic valueForKey:@"site"] ) {
               cell.detailTextLabel.text = nil;
           }
           else
           {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",[_dic valueForKey:@"site"],[_dic valueForKey:@"siteStr"]];
           }
       }
    }
    else
    {
        cell.textLabel.text = _titleArrayTwo[indexPath.row];
        if ([_titleArrayTwo[indexPath.row] isEqual:@"联系电话"]) {
            cell.detailTextLabel.text = @"0571-87015856";
            cell.detailTextLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 15];
            cell.detailTextLabel.textColor = RGBA(102, 102, 102, 1);
        }
        
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = nil;
    header = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH,100)];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, 100)];
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
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 100;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = nil;
    if (section == 1) {
        footer = [[UIView alloc]initWithFrame:CGRectMake(15,0, SCREENWIDTH,108)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectZero];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 12];
        lab.numberOfLines = 0;
        lab.text = @"合作伙伴可以利用位于娱悦现场APP上的爆款来做品牌宣传、商品广告等推广";
        CGFloat min_h = [lab.text textSizeWithFont:[UIFont fontWithName:@"PingFang-SC-Medium" size: 12] numberOfLines:2 lineSpacing:16 constrainedWidth:SCREENWIDTH].height;
        lab.textColor = RGBA(153, 153, 153, 1);
        [footer addSubview:lab];
        [lab makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footer.centerY);
            make.right.equalTo(-15);
            make.left.equalTo(15);
            make.height.equalTo(min_h);
        }];
        footer.backgroundColor = RGBA(243, 243, 243, 1);
    }

    return footer;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
        return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //营业执照
        BusinessLicenseViewController *licenseVC = [[BusinessLicenseViewController alloc] init];
        //身份证上传
        UploadIdCardViewController    *upVC= [[UploadIdCardViewController alloc] init];
        switch (indexPath.row) {
            case 0:
            {
                _addressView.hidden = NO;
                typeof(self) weakSelf =self;
                _addressView.click = ^(UIButton * _Nonnull btn) {
                    
                    switch (btn.tag) {
                        case 1:
                        {
                       
                                weakSelf.addressView.hidden = YES;
                        
                        }
                             break;
                        case 2:
                        {
                            ShowPickerView *areaPickerView = [[ShowPickerView alloc] initWithFrame:weakSelf.view.bounds];
                            areaPickerView.delegate = (id)weakSelf;
                            [areaPickerView showPicker];
                        }
                            break;
                        case 3:
                        {
                            [weakSelf.adverjistTableView reloadData];
                                weakSelf.addressView.hidden = YES;
                        }
                            break;
                        default:
                            break;
                    }
                    
                };
            }
                break;
            case 1:
                [self.navigationController pushViewController:licenseVC animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:upVC animated:YES];
                break;
            case 3:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 4:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 5:
            {
                PhomeNumberViewController *vc = [[PhomeNumberViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            default:
                break;
        }
    }
    else
        switch (indexPath.row) {
            case 0:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 1:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 2:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 3:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 4:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            case 5:
                NSLog(@"%ld",(long)indexPath.row);
                break;
            default:
                break;
        }
}

- (void)showPickerViewDone:(NSString *)chooseTitle chooseId:(NSString *)chooseId
{
    _addressView.selectLabel.text = chooseTitle;
    [_dic setValue:chooseTitle forKey:@"site"];
}
- (void)textFieldEditChanged:(UITextField *)textField
{
    [_dic setValue:textField.text forKey:@"siteStr"];
}
@end
