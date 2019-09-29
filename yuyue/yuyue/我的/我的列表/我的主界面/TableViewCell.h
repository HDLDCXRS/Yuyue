//
//  TableViewCell.h
//  yuYue
//
//  Created by edz on 2019/8/7.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CellBlock)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView  * imgView;
@property(nonatomic,strong) UILabel  * titleLabel;
@property(nonatomic,strong) UIButton  * rowBtn;
@property(nonatomic,strong) CellBlock  clickBtn;
@end

NS_ASSUME_NONNULL_END
