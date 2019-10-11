//
//  CommentTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView  *iconImage;
@property(nonatomic,strong) UILabel  *iconLabel;
@property(nonatomic,strong) UILabel  *timeLabel;
@property(nonatomic,strong) UILabel  *contentLabel;
@end

NS_ASSUME_NONNULL_END
