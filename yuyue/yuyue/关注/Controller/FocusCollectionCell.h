//
//  FocusCollectionCell.h
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FocusCollectionCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView  *pictureImageView;
//@property(nonatomic,strong) UILabel  * titleLabel;
@property(nonatomic,strong) UIImageView  *iconImage;
@property(nonatomic,strong) UILabel  *iconLabel;
@property(nonatomic,strong) UIButton  *stateBtn;
@property(nonatomic,strong) FocusModel  *model;
-(void)setModel:(FocusModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
