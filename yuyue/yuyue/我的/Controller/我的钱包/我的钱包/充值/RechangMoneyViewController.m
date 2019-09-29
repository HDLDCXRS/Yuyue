//
//  RechangMoneyViewController.m
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import "RechangMoneyViewController.h"
#import <StoreKit/StoreKit.h>
#import "SVProgressHUD.h"
@interface RechangMoneyViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate,SKRequestDelegate>
@property (nonatomic,copy) NSString *currentProId;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@end

@implementation RechangMoneyViewController
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
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    [btn1 setTitle:@"充值j6元" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn1];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 180, 100, 100)];
    [btn2 setTitle:@"充值6元" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn2];
//    _currentProId = @"com.applepaycompany.heyuan.6";
    
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"requestDidFinish");
    //从沙盒中获取交易凭证
    NSData *reciptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSString *reciptString = [reciptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [self checkReceipt:reciptString];
}

-(void)clickBtn1 {
    NSSet *sets = [NSSet setWithObjects:@"com.applepaycompany.heyuan.6", nil];
    SKProductsRequest *productrequest = [[SKProductsRequest alloc] initWithProductIdentifiers:sets];
    productrequest.delegate = self;
    [productrequest start];
    //首先我们要在 viewDidLoad 方法中添加监听对象
    
}
-(void)clickBtn2 {
    NSSet *sets = [NSSet setWithObjects:@"com.applepaycompany.heyuan.6", nil];
    SKProductsRequest *productrequest = [[SKProductsRequest alloc] initWithProductIdentifiers:sets];
    productrequest.delegate = self;
    [productrequest start];
    //首先我们要在 viewDidLoad 方法中添加监听对象
    
}

#pragma mark - 获取商品ID成功的代理方法
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    //返回的是SKProduct对象数组
    //如果你上面请求的是多个，那么这里返回的也是多个
    if (response) {
        SKProduct *product = [response.products firstObject];
        //查询成功，开始支付
        [self startPaymentWithProduct:product];
    }
}

#pragma mark -- 拿到商品信息，创建支付对象
- (void)startPaymentWithProduct:(SKProduct *)product {
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.applicationUsername = @"com.applepaycompany.heyuan.6";
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark -  监听的代理方法
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKPaymentTransaction *transation = obj;
        switch (transation.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            {
                NSLog(@"购买中");
            }
                break;
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"交易完成");
                //获取透传字段
                NSString *orderNo = transation.payment.applicationUsername;
                //transactionIdentifier：相当于Apple的订单号
                NSString *transationId = transation.transactionIdentifier;
                self->_currentProId = transationId;
                NSLog(@"orderNo = %@, 交易ID = %@", orderNo, transationId);
                //从沙盒中获取交易凭证
                NSData *reciptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
                //转化成Base64字符串（用于校验）
                /*
                 //其作用是将生成的Base64字符串按照64个字符长度进行等分换行。
                 NSDataBase64Encoding64CharacterLineLength = 1UL << 0,
                 //其作用是将生成的Base64字符串按照76个字符长度进行等分换行。
                 NSDataBase64Encoding76CharacterLineLength = 1UL << 1,
                 //其作用是将生成的Base64字符串以回车结束。
                 NSDataBase64EncodingEndLineWithCarriageReturn = 1UL << 4,
                 //其作用是将生成的Base64字符串以换行结束。
                 NSDataBase64EncodingEndLineWithLineFeed = 1UL << 5,
                 */
//                NSString *reciptString = [reciptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                NSString *reciptString = [reciptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                //NSLog(@"%@",reciptString);
                //传给后台做二次验证
                [self checkReceipt:reciptString];
                [[SKPaymentQueue defaultQueue] finishTransaction:transation];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                //localizedDescription可以作为提示信息（交易失败无法连接到 iTunes Store）
                NSLog(@"交易失败%@", transation.error.localizedDescription);
                [[SKPaymentQueue defaultQueue] finishTransaction:transation];
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"恢复购买完成");
                //恢复完成（对应restoreCompletedTransactions）方法
            }
                break;
            case SKPaymentTransactionStateDeferred:
            {
                NSLog(@"交易推迟, 等待外部操作");
                //交易推迟
                //官方解释是：交易已经加入队列，但是需要等待外部操作
                //主要用于儿童模式，需要询问家长同意。这种情况下不能关闭订单（完成交易），否则这类充值将无法处理。
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark -- 从沙盒中取到凭证，发送给我们自己后台进行二次验证，验证成功表示支付成功
- (void)checkReceipt:(NSString *)receipt {
    NSDictionary *dic = @{
                          @"TransactionID":_currentProId,
                          @"Payload":receipt
                          };
    [self.manager POST:@"pay/doIosRequest?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"+++++");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
@end



