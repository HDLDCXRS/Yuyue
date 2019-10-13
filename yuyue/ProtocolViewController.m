//
//  ProtocolViewController.m
//  yuyue
//
//  Created by edz on 2019/10/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()
@property(nonatomic,strong) UIScrollView  *scrollView;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UIButton  *btn;
@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
//    if (@available(iOS 11.0, *)) {
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(0);
    }];
    _titleLabel = [[UILabel alloc] init];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Protocalpolist" ofType:@"plist"];
    NSDictionary *dic=[[NSDictionary alloc]initWithContentsOfFile:path];
    _titleLabel.text = [dic valueForKey:@"string"];
    NSString *strUrl = [_titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    strUrl= [strUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font =[UIFont fontWithName:@"PingFang SC" size: 11];
   CGSize size = [strUrl textSizeWithFont: [UIFont fontWithName:@"PingFang SC" size: 11] numberOfLines:0 constrainedWidth:_scrollView.bounds.size.width];
    [self.scrollView addSubview:_titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(-5);
        make.height.equalTo(size.height+800);
    }];
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT+size.height+200);
    _btn = [UIButton buttonWithFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"意见"] setTitle:@"确定" setTitleColor:[UIColor whiteColor] addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    [_btn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-15);
        make.left.offset(15);
        make.right.equalTo(-15);
        make.height.equalTo(44);
    }];
}
-(void)onClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
