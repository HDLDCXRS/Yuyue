//
//  HBK_ScanViewController.m
//  HBK_Scan
//
//  Created by 黄冰珂 on 2017/11/15.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HBK_ScaningView.h"
#import "RealNameViewController.h"
@interface HBK_ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) HBK_ScaningView *scanningView;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@end

@implementation HBK_ScanViewController
-(AFHTTPSessionManager*)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:WEBURLA];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
         [_manager.requestSerializer setValue: [NSString stringWithFormat:@"eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJCMDQ0QzUzQjM4QkE0RTg0QjUwN0U2MjQwMjY4M0UyNiJ9.l1NBzuvQd0h3LdM9Id8IxpjeWhZgrzIviQJwKNJjgFM"] forHTTPHeaderField:@"token"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建扫描边框
    self.scanningView = [[HBK_ScaningView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
    // 二维码扫描
    [self setupScanningQRCode];
}
// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
}

#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
//    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
//    output.rectOfInterest = CGRectMake(0.15, 0.24, 0.7, 0.52);
    
    // 5、 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    [_scanningView removeFromSuperview];
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
            if ([obj.stringValue hasPrefix:@"http"]) {
                // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
                NSLog(@"扫描网址为----------%@", obj.stringValue);
                [self postURL:obj.stringValue];
            } else { // 扫描结果为条形码
                NSLog(@"扫描条形码为----------%@", obj.stringValue);
               [self postURL:obj.stringValue];
            }
        
    }
}

-(void)postURL:(NSString *)str
{
    NSLog(@"%@",str);
    NSDictionary *dic = @{
                          @"siteId":str
                          };
    [self.manager POST:@"myController/analysisCode" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"%@",responseObject[@"message"]);
        [self.navigationController pushViewController:[[RealNameViewController alloc] init ]animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
