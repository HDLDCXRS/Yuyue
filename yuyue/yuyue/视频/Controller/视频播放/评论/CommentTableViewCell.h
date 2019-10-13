//
//  CommentTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetAllCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView  *iconImage;
@property(nonatomic,strong) UILabel  *iconLabel;
@property(nonatomic,strong) UILabel  *timeLabel;
@property(nonatomic,strong) UILabel  *contentLabel;
@property(nonatomic,strong) GetAllCommentModel  *model;
-(void)setModel:(GetAllCommentModel * _Nonnull)model;

@end

NS_ASSUME_NONNULL_END
