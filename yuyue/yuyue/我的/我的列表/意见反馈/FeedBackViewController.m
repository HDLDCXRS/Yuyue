//
//  FeedBackViewController.m
//  yuyue
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackView.h"
#import "FeedSuccessViewController.h"
#import "PostPhotoModel.h"
@interface FeedBackViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong) FeedBackView  *feedObject;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSString  *url;
@property(nonatomic,strong) NSMutableDictionary  *dic;

@end

@implementation FeedBackViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        [_manager.requestSerializer setValue: [NSString stringWithFormat:@"%@",TOKEN] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"意见反馈";
    _dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    self.view.backgroundColor = [UIColor whiteColor];
    _feedObject = [[FeedBackView alloc] init];
    [self.view addSubview:_feedObject];
    [_feedObject makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NavBar_Height);
        make.right.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
    }];
    _feedObject.contentTextView.delegate = self;
    [_feedObject.textField addTarget:self action:@selector(changLabel:) forControlEvents:UIControlEventValueChanged];
    typeof(self) weakSelf = self;
    _feedObject.click = ^(UIButton *btn) {
        switch (btn.tag) {
            case 100:
                {
                    [weakSelf showActionSheet];
                }
                break;
            case 101:
                [weakSelf  postSuggestUrlMethod];
                break;
            default:
                break;
        }
       
    };
}
-(void)changLabel:(UITextField *)textView
{
    [_dic setValue:textView.text forKey:@"contact"];
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger maxFontNum = 100;//最大输入限制
    NSString *toBeString = textView.text;
    // 获取键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxFontNum) {
                textView.text = [toBeString substringToIndex:maxFontNum];//超出限制则截取最大限制的文本
                self.feedObject.limitLabel.text = [NSString stringWithFormat:@"%ld/100",maxFontNum];
            } else {
                self.feedObject.limitLabel.text = [NSString stringWithFormat:@"%ld/100",toBeString.length];
            }
        }
    } else {// 中文输入法以外的直接统计
        if (toBeString.length > maxFontNum) {
            textView.text = [toBeString substringToIndex:maxFontNum];
            self.feedObject.limitLabel.text = [NSString stringWithFormat:@"%ld/100",maxFontNum];
        } else {
           self.feedObject.limitLabel.text = [NSString stringWithFormat:@"%ld/100",toBeString.length];
        }
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
   // [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_feedObject.photoBtn setBackgroundImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self postPhotoMethod];
}
-(void)postPhotoMethod
{
    typeof(self) weakSelf = self;
    //把图片转成data
    NSData *imageData = UIImageJPEGRepresentation(self.feedObject.photoBtn.currentBackgroundImage, 0.7);
//    NSDictionary *dic = @{
//                          @"file":imageData
//                          };
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
-(void)postSuggestUrlMethod
{
//    NSMutableDictionary *dic = @{
//                          @"pictureUrl":_url,
//                          @"details"  :_feedObject.contentTextView.text,
//                          @"contact"  :_feedObject.textField.text
//                          };
    
//    NSLog(@"%@",dic);
    [self.dic setValue:self.feedObject.contentTextView.text forKey:@"details"];
    [self.dic setValue:self.feedObject.textField.text forKey:@"contact"];
    [self.dic setValue:self.url forKey:@"pictureUrl"];
   
   
    NSLog(@"%@",_dic);
    typeof(self) weakSelf = self;
    [self.manager POST:@"myController/feedback" parameters:_dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"status"] boolValue] == true) {
                    FeedSuccessViewController *vc  = [[FeedSuccessViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    NSLog(@"+++++++");
                }
                else
                {
                    if (![weakSelf.dic valueForKey:@"pictureUrl"]) {
                        UIAlertController * alter   = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"图片不能为空" andCancelInfo:@"确定"];
                        [weakSelf presentViewController:alter animated:YES completion:nil];
                    }
                   else if (![weakSelf.dic valueForKey:@"contact"]) {
                        UIAlertController * alter   = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"内容不能为空" andCancelInfo:@"确定"];
                        [weakSelf presentViewController:alter animated:YES completion:nil];
                    }
                   else if (![weakSelf.dic valueForKey:@"details"]) {
                        UIAlertController * alter   = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"联系方式不能为空" andCancelInfo:@"确定"];
                        [weakSelf presentViewController:alter animated:YES completion:nil];
                    }
                   else {
                        UIAlertController * alter   = [UIAlertController alertCancelWithTitle:@"温馨提示" andMessage:@"请勿重复提交" andCancelInfo:@"确定"];
                        [weakSelf presentViewController:alter animated:YES completion:nil];
                    }
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(BOOL)isNullToDictionary:(NSDictionary *)dict
{
    
    if (dict != nil && ![dict isKindOfClass:[NSNull class]] && dict.count != 0){
        
        return NO;
        
    }else{
        
        return YES;
    }
}

@end
