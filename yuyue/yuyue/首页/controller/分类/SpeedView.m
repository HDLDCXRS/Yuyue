//
//  SpeedView.m
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import "SpeedView.h"
#import "SpeedViewCell.h"
@interface SpeedView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView  * titleCollectionView;
@property(nonatomic,strong)  UICollectionViewFlowLayout  *layout  ;
@end
@implementation SpeedView
- (void)setDataSourse:(NSArray *)dataSourse {
    _dataSourse = dataSourse;
    [self.titleCollectionView reloadData];
}
- (UICollectionView *)titleCollectionView {
    if (_titleCollectionView == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        
        self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 188) collectionViewLayout:_layout];
        self.titleCollectionView.delegate = self;
        self.titleCollectionView.dataSource = self;
        [self.titleCollectionView registerClass:[SpeedViewCell class] forCellWithReuseIdentifier:@"workForGroup"];
        //self.titleCollectionView.backgroundColor = [UIColor whiteColor];
        _titleCollectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleCollectionView];
        [self.titleCollectionView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.right.bottom.equalTo(0);
        }];
      
        
    }
    return _titleCollectionView;
}
#pragma make  -  UICollectionView的代理方法
//cell赋值
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpeedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"workForGroup" forIndexPath:indexPath];
    [cell setModel:self.dataSourse[indexPath.item % self.dataSourse.count]];
    cell.tag = indexPath.item;
   // [cell setModel:self.dataSourse[indexPath.item]];
    return cell;
}
//每个section中item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.MainImgArray.count;
    return self.dataSourse.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH/4, 73);
}
//设置每个item的垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 14;
}
//每一个cell之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     //NSLog(@"第几张图----%lu",indexPath.item%self.dataSourse.count);
    if (self.clickBlock) {
       self.clickBlock(indexPath.item);
    }
}
@end
