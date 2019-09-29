//
//  MainADCell.h
//  yuYue
//
//  Created by edz on 2019/8/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainADModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainADCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property(nonatomic,strong) MainADModel * model;
-(void)setModel:(MainADModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
