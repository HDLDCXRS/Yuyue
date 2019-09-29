//
//  AboutOurViewController.m
//  yuyue
//
//  Created by edz on 2019/9/3.
//  Copyright © 2019 edz. All rights reserved.
//

#import "AboutOurViewController.h"

@interface AboutOurViewController ()

@end

@implementation AboutOurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"关于我们";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
    _bgcImgView.backgroundColor = RGBA(243, 243, 243, 1);
    _bgcFootView.backgroundColor = RGBA(243, 243, 243, 1);
    _iconLabel.font = [UIFont fontWithName:@"PingFang SC" size: 13];
    _iconLabel.textColor = RGBA(58, 134, 254, 1);
    //版本号
    _versonLabel.textColor = RGBA(153, 153, 153, 1);
    _versonLabel.font =[UIFont fontWithName:@"PingFang SC" size: 11];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versonLabel.text = app_Version;
    _actionLabel.font = [UIFont fontWithName:@"PingFang SC" size: 15];
    _actionLabel.textColor =RGBA(153, 153, 153, 1);
    _artLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    _artLabel.textColor =RGBA(153, 153, 153, 1);
    _connectLabel.textColor =RGBA(51, 51, 51, 1);
    _connectLabel.font = [UIFont fontWithName:@"PingFang SC" size: 16];
    _connectPhoneLabel.textColor =RGBA(102, 102, 102, 1);
    _connectPhoneLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 15];
    _connectTimeLabel.textColor =RGBA(51, 51, 51, 1);
    _connectTimeLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    _timeLabel.textColor =RGBA(102, 102, 102, 1);
    _timeLabel.font =[UIFont fontWithName:@"PingFang SC" size: 15];
    _companyLabel.font =[UIFont fontWithName:@"PingFang SC" size: 12];
    _companyLabel.textColor = RGBA(102, 102, 102, 1);
}


@end
