//
//  SpeedViewCell.h
//  yuYue
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpeedViewCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView  * iconImg;
@property(nonatomic,strong) UILabel  * iconLabel;
@property(nonatomic,strong) SpeedModel  *model;
-(void)setModel:(SpeedModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
