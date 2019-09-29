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

#import "BaseCommonTableViewCell.h"
#import "SexPickerTool.h"
#import "PostPhotoModel.h"
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) BaseView  * baseView;
@property(nonatomic,strong) UITableView  * aTableView;
@property(nonatomic,strong) BassInformationTableViewCell  * cell;
@property(nonatomic,strong) NSArray  * titleArray;
@property(nonatomic,strong) NSArray  * contentArray;

@property(nonatomic,assign) NSInteger  count;
@property(nonatomic,strong) NSMutableDictionary  *dic;  //保存信息
@property(nonatomic,strong) AFHTTPSessionManager  *manager;


@end

@implementation BaseViewController
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
- (NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _dic;
}
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
    [self initNavagation];
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
     typeof(self) weakSelf = self;
    _baseView.click = ^(UIButton * _Nonnull btn) {
        [weakSelf pickPhoto];
    };

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
       // _count = indexPath.row;
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titlleLabel.text = _titleArray[indexPath.row];
        cell.inputTextField.placeholder = _contentArray[indexPath.row];
        cell.inputTextField.tag = indexPath.row;
        [cell.inputTextField addTarget:self action:@selector(textFieldsChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
   else
   {
       BaseCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
       cell.titlleLabel.text = _titleArray[indexPath.row];
       if (indexPath.row == 1) {
           if ([_dic valueForKey:@"sex"]) {
               cell.inputTextField.text = [_dic valueForKey:@"sex"];
           }
           else
           {
               cell.inputTextField.text = _contentArray[indexPath.row];
           }
       }
       else  if (indexPath.row == 3)
       {
           if ([_dic valueForKey:@"education"]) {
               cell.inputTextField.text = [_dic valueForKey:@"education"];
           }
           else
           {
               cell.inputTextField.text = _contentArray[indexPath.row];
           }
       }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       return cell;
   }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==1  || indexPath.row == 3) {
        _count = indexPath.row;
        [self sexMethod];
    }
}
-(void)textFieldsChange:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            [self.dic setValue:textField.text forKey:@"nickName"];
            break;
        case 2:
             [self.dic setValue:textField.text forKey:@"wechat"];
            break;
        case 4:
             [self.dic setValue:textField.text forKey:@"signature"];
            break;
        default:
            break;
    }
    
}
//选择器方法
-(void)sexMethod
{
    NSArray *arr = @[@"男",@"女"];
    NSArray *arr2 = @[@"高中以及以下",@"大专",@"本科",@"硕士",@"博士"];
    if (_count == 1) {
        SexPickerTool *sexPick = [[SexPickerTool alloc] initWithFrame:CGRectMake(0,SCREENHEIGHT-200, self.view.frame.size.width, 200) DataSorce:arr];
         typeof(self) weakSelf = self;
        __block SexPickerTool *blockPicker = sexPick;
        sexPick.callBlock = ^(NSString *pickDate) {
            NSLog(@"%@",pickDate);
            if (pickDate) {
                [weakSelf.dic setValue:pickDate forKey:@"sex"];
                
            }
            [blockPicker removeFromSuperview];
            [weakSelf.aTableView reloadData];
        };
        [self.view addSubview:sexPick];
    }
    else
    {
        SexPickerTool *sexPick = [[SexPickerTool alloc] initWithFrame:CGRectMake(0,SCREENHEIGHT-200, self.view.frame.size.width, 200) DataSorce:arr2];
        __block SexPickerTool *blockPicker = sexPick;
         typeof(self) weakSelf = self;
        sexPick.callBlock = ^(NSString *pickDate) {
            NSLog(@"%@",pickDate);
            if (pickDate) {
                 [weakSelf.dic setValue:pickDate forKey:@"education"];
            }
             [blockPicker removeFromSuperview];
             [weakSelf.aTableView reloadData];
        };
        [self.view addSubview:sexPick];
    }
    
}
-(void)initNavagation
{
    //设置背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton  *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,36,28,14)];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 15];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
-(void)rightBtnClick
{
    [self updateAppUserMethod];
}
//用户信息修改
-(void)updateAppUserMethod
{
    
    [self.manager POST:@"login/updateAppUser" parameters:_dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         typeof(self) weakSelf = self;
        if ([responseObject[@"status"] boolValue] == true) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"%@",responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    //NSLog(@"%@",_dic);
}
//相册相关的
-(void)pickPhoto
{
    [self showActionSheet];
    
    
}
-(void)showActionSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"请打开权限" andCancelInfo:@"返回"];
            [self presentViewController:alter animated:YES completion:nil];
            return;
        }
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"相机不可用" andCancelInfo:@"返回"];
            [self presentViewController:alter animated:YES completion:nil];
            return;
        }
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_baseView.photoBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self postPhotoMethod];
}
-(void)postPhotoMethod
{
    NSData *imageData = UIImageJPEGRepresentation(self.baseView.photoBtn.currentBackgroundImage, 0.7);
    NSDictionary *dic = @{
                          @"file":imageData
                          };
     typeof(self) weakSelf = self;
    [self.manager POST:@"uploadFile/uploadServer" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"++++++guocheng");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            NSArray *arr = [NSArray yy_modelArrayWithClass:[PostPhotoModel class] json:responseObject[@"result"][@"uploadFile"]];
            PostPhotoModel *model = arr[0];
            [weakSelf.dic setValue:model.filesPath forKey:@"headpUrl"];
        }
        else
        {
            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}
@end
