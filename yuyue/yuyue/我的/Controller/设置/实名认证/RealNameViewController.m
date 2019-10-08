//
//  RealNameViewController.m
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RealNameViewController.h"
#import "RealNameView.h"
#import "CheckCode.h"
#import "PassRealNameViewController.h"
#import "PostPhotoModel.h"
@interface RealNameViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) RealNameView  *realView;
@property(nonatomic,strong) UIButton  *finishBtn;
@property(nonatomic,assign) NSInteger  count;
@property(nonatomic,strong) NSMutableDictionary  *dic;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSString  *url;
@end

@implementation RealNameViewController
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
- (UIButton *)finishBtn
{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"完成" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(finishMehod:) forControlEvents:UIControlEventTouchUpInside];
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.layer.cornerRadius = 5;
    }
    return _finishBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"实名认证";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.finishBtn];
    [self.finishBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-19);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(40);
    }];
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.finishBtn.top).offset(-43);
    }];
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    _realView = [[RealNameView alloc] init];
    _realView.nameTextField.delegate = self;
    _realView.idTextField.delegate = self;
    [_scrollView addSubview:_realView];
    _realView.userInteractionEnabled = YES;
    [_realView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(SCREENHEIGHT);
    }];
    typeof(self) weakSelf = self;
    _realView.click = ^(UIButton *btn) {
        switch (btn.tag) {
            case 1:
                weakSelf.count = 1;
                [weakSelf showActionSheet];
                //[weakSelf.realView.postRightPhotoBtn setImage:weakSelf.image forState:UIControlStateNormal];
               
                break;
            case 2:
                 weakSelf.count = 2;
                 [weakSelf showActionSheet];
                
                break;
            case 3:
                 weakSelf.count = 3;
                [weakSelf showActionSheet];
                break;
            default:
                break;
        }
    };
}

-(void)finishMehod:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.realView.idTextField) {
        if ([CheckCode judgeIdentityStringValid:textField.text postUIViewController:self ]) {
            [_dic setValue:textField.text forKey:@"idCard"];
        }
    }
    else
    {
        [_dic setValue:textField.text forKey:@"realName"];
    }
        

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
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    _image = image;
    if (self.count == 1) {
        [self.realView.postRightPhotoBtn setImage:image forState:UIControlStateNormal];
        //self
    }
    else if(self.count == 2)
    {
       [self.realView.postReversePhotoBtn setImage:image forState:UIControlStateNormal];
        //[picker dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.realView.postHandPhotoBtn setImage:image forState:UIControlStateNormal];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)postPhotoMethod1
{
    typeof(self) weakSelf = self;
    //把图片转成data
    NSData *imageData = UIImageJPEGRepresentation(self.realView.postRightPhotoBtn.currentBackgroundImage, 0.7);
    //上传data
    [self.manager POST:@"uploadFile/uploadServer" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //创建一个格式化日期对象
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //日期的格式
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        //将日期转变成字符串
        NSString *str = [formatter stringFromDate:[NSDate date]];
        //设置图片的名字
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //  FileData 是图片的数据流    fileName是文件名   name 是后台给的图片参数   mimeType 是文件类型
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"++++++guocheng");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            PostPhotoModel *model = [PostPhotoModel yy_modelWithJSON:responseObject[@"result"][@"uploadFile"][0]];
            weakSelf.url = model.filesPath;
            NSLog(@"%@",responseObject);
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}
-(void)postPhotoMethod2
{
    typeof(self) weakSelf = self;
    //把图片转成data
    NSData *imageData = UIImageJPEGRepresentation(self.realView.postReversePhotoBtn.currentBackgroundImage, 0.7);
    //上传data
    [self.manager POST:@"uploadFile/uploadServer" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //创建一个格式化日期对象
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //日期的格式
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        //将日期转变成字符串
        NSString *str = [formatter stringFromDate:[NSDate date]];
        //设置图片的名字
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //  FileData 是图片的数据流    fileName是文件名   name 是后台给的图片参数   mimeType 是文件类型
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"++++++guocheng");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            PostPhotoModel *model = [PostPhotoModel yy_modelWithJSON:responseObject[@"result"][@"uploadFile"][0]];
            weakSelf.url = model.filesPath;
            NSLog(@"%@",responseObject);
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}
-(void)postPhotoMethod3
{
    typeof(self) weakSelf = self;
    //把图片转成data
    NSData *imageData = UIImageJPEGRepresentation(self.realView.postReversePhotoBtn.currentBackgroundImage, 0.7);
    //上传data
    [self.manager POST:@"uploadFile/uploadServer" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //创建一个格式化日期对象
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //日期的格式
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        //将日期转变成字符串
        NSString *str = [formatter stringFromDate:[NSDate date]];
        //设置图片的名字
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //  FileData 是图片的数据流    fileName是文件名   name 是后台给的图片参数   mimeType 是文件类型
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"++++++guocheng");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] boolValue] == true) {
            PostPhotoModel *model = [PostPhotoModel yy_modelWithJSON:responseObject[@"result"][@"uploadFile"][0]];
            weakSelf.url = model.filesPath;
            NSLog(@"%@",responseObject);
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}
@end
