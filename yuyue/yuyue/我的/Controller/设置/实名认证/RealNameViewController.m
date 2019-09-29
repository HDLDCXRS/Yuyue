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
@interface RealNameViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) RealNameView  *realView;
@property(nonatomic,strong) UIButton  *finishBtn;
@property(nonatomic,assign) NSInteger  count;
@end

@implementation RealNameViewController
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
                 //[weakSelf.realView.postReversePhotoBtn setImage:weakSelf.image forState:UIControlStateNormal];
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
        [CheckCode judgeIdentityStringValid:textField.text postUIViewController:self];
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
        //[picker dismissViewControllerAnimated:YES completion:nil];
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
@end
