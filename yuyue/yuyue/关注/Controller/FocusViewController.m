//
//  FocusViewController.m
//  yuYue
//
//  Created by edz on 2019/8/5.
//  Copyright © 2019 edz. All rights reserved.
//

#import "FocusViewController.h"
#import "FocusCollectionCell.h"
#import "FocusModel.h"
@interface FocusViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)  UICollectionView  * titleCollectionView;
@property(nonatomic,strong)  UICollectionViewFlowLayout  *layout  ;
@property(nonatomic,strong) AFHTTPSessionManager  *manager;
@property(nonatomic,strong) NSArray  *arrayCount;
@end

@implementation FocusViewController
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
-(void)requestData
{
    typeof(self) weakSelf = self;
    [self.manager POST:@"userComment/getUserAttention" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"message"] isEqualToString:@"返回成功！！"]) {
            weakSelf.arrayCount = [NSArray yy_modelArrayWithClass:[FocusModel class] json:responseObject[@"result"]];
            [weakSelf.titleCollectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    _layout = [[UICollectionViewFlowLayout alloc] init];
    //设置行与行的间距
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    [self.titleCollectionView registerClass:[FocusCollectionCell class] forCellWithReuseIdentifier:@"workForGroup"];
    
    _titleCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.titleCollectionView];
    [self.titleCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.bottom.equalTo(0);
    }];
    [self requestData];
}

#pragma make  -  UICollectionView的代理方法
//cell赋值
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FocusCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"workForGroup" forIndexPath:indexPath];
    //[cell setModel:self.dataSourse[indexPath.item % self.dataSourse.count]];
    cell.tag = indexPath.item;
    cell.model = _arrayCount[indexPath.item];
    // [cell setModel:self.dataSourse[indexPath.item]];
    return cell;
}
//每个section中item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _arrayCount.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREENWIDTH-30)/2, 240);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 10, 10);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"第几张图----%lu",indexPath.item%self.dataSourse.count);
//    if (self.clickBlock) {
//        self.clickBlock(indexPath.item);
//    }
}


@end
