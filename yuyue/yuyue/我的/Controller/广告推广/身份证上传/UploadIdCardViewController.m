//
//  UploadIdCardViewController.m
//  yuyue
//
//  Created by edz on 2019/8/26.
//  Copyright © 2019 edz. All rights reserved.
//

#import "UploadIdCardViewController.h"

@interface UploadIdCardViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIButton  * photoBtn;
@property(nonatomic,strong) UIImageView  * headBgcView;
@property(nonatomic,strong) UILabel  * headtitle;
@property(nonatomic,strong) UILabel  * idCardLabel;
@property(nonatomic,strong) UIButton  * resverBtn;
@property(nonatomic,strong) UILabel  * resverLabel;
@property(nonatomic,strong) UIImagePickerController  * picker;
@property(nonatomic,assign) NSInteger  count;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@end

@implementation UploadIdCardViewController
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
-(UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
    }
    return _picker;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =@"身份证上传";
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _headBgcView = [[UIImageView alloc] init];
    [self.view addSubview:_headBgcView];
    _headBgcView.backgroundColor = RGBA(243, 243, 243, 1);
    [_headBgcView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.left.right.equalTo(0);
        make.height.equalTo(32);
    }];
    _headtitle = [[UILabel alloc] init];
    _headtitle.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    _headtitle.text = @"拍摄时请确保身份证边框完整、字迹清晰、亮度均衡";
    _headtitle.textColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_headtitle];
    [_headtitle makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headBgcView.centerY);
        make.left.equalTo(15);
        make.height.equalTo(12);
        make.right.equalTo(0);
    }];
    _photoBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"正面"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(pickPhoto:) forControlEvents:UIControlEventTouchUpInside];
    _photoBtn.tag = 1;
    CGSize  size = _photoBtn.currentBackgroundImage.size;
    [self.view addSubview:_photoBtn];
    [_photoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headBgcView.bottom).offset(49);
        make.left.equalTo(90);
        make.right.equalTo(-90);
        make.height.equalTo(size.height);
    }];
    _idCardLabel = [[UILabel alloc] init];
    _idCardLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    _idCardLabel.text = @"身份证正面";
    _idCardLabel.textColor =RGBA(102, 102, 102, 1);
    [self.view addSubview:_idCardLabel];
    [_idCardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoBtn.bottom).offset(13);
        make.centerX.equalTo(self.photoBtn.centerX);
        make.height.equalTo(12);
    }];
    //身份证反面
    _resverBtn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"反面"] setTitle:nil setTitleColor:nil addTarget:self action:@selector(pickPhoto:) forControlEvents:UIControlEventTouchUpInside];
    _resverBtn.tag = 2;
       size = _resverBtn.currentBackgroundImage.size;
    [self.view addSubview:_resverBtn];
    [_resverBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardLabel.bottom).offset(58);
        make.left.equalTo(90);
        make.right.equalTo(-90);
        make.height.equalTo(size.height);
    }];
    _resverLabel = [[UILabel alloc] init];
    _resverLabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    _resverLabel.text = @"身份证反面";
    _resverLabel.textColor =RGBA(102, 102, 102, 1);
    [self.view addSubview:_resverLabel];
    [_resverLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resverBtn.bottom).offset(11);
        make.centerX.equalTo(self.resverBtn.centerX);
        make.height.equalTo(12);
    }];
}
-(void)pickPhoto:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
            _count = 1;
            [self showActionSheet];
            
            break;
        case 2:
            _count =2 ;
            [self showActionSheet];
            break;
        default:
            break;
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
        [self.photoBtn setImage:image forState:UIControlStateNormal];
        [self postPhotoMethod];
    }
    else if(self.count == 2)
    {
        [self.resverBtn setImage:image forState:UIControlStateNormal];
        [self postPhotoMethod];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //图片在这里压缩一下
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    //    if (imageData.length/1024 > 1024*20)
    //    {
    //        //        mAlertView(@"温馨提示", @"请重新选择一张不超过20M的图片");
    //    }
    //    else
    //    {
    //        //        _imageType = [NSData typeForImageData:imageData];
    //        //        _imageBase64 = [imageData base64EncodedString];
    //    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
