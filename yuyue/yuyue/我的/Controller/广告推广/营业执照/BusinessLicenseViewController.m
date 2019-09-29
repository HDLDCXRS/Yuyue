//
//  BusinessLicenseViewController.m
//  yuyue
//
//  Created by edz on 2019/8/26.
//  Copyright © 2019 edz. All rights reserved.
//

#import "BusinessLicenseViewController.h"

@interface BusinessLicenseViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIButton  * photoBtn;
@property(nonatomic,strong) UIImageView  * headBgcView;
@property(nonatomic,strong) UILabel  * idCardLabel;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@end

@implementation BusinessLicenseViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@", TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"营业执照";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _headBgcView = [[UIImageView alloc] init];
    [self.view addSubview:_headBgcView];
    _headBgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [_headBgcView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(10);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    _photoBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"营业执照"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchUpInside];
    CGSize  size = _photoBtn.currentBackgroundImage.size;
    [self.view addSubview:_photoBtn];
    [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headBgcView.bottom).offset(46);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    _idCardLabel = [[UILabel alloc] init];
    _idCardLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    _idCardLabel.text = @"营业执照上传";
    _idCardLabel.textColor =RGBA(102, 102, 102, 1);
    [self.view addSubview:_idCardLabel];
    [_idCardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoBtn.bottom).offset(18);
        make.centerX.equalTo(self.photoBtn.centerX);
        make.height.equalTo(12);
    }];
}

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
    [_photoBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self postPhotoMethod];
}
-(void)postPhotoMethod
{
    NSData *imageData = UIImageJPEGRepresentation(self.photoBtn.currentBackgroundImage, 0.7);
    NSDictionary *dic = @{
                          @"file":imageData
                          };
    [self.manager POST:@"uploadFile/uploadServer" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"++++++guocheng");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"上传文件成功!"]) {
            NSLog(@"%@",responseObject);
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
