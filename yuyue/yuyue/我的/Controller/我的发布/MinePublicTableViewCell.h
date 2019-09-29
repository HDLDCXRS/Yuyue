//
//  MinePublicTableViewCell.h
//  yuYue
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinePublishModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MinePublicTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView  *headImgView; //用户头像
@property(nonatomic,strong) UILabel  * titleLabel;   //用户名称
@property(nonatomic,strong) UILabel *timeLabel;   //时间
@property(nonatomic,strong) UILabel  * stateLabel;  //状态
@property(nonatomic,strong) UILabel  * contentLabel; //内容
@property(nonatomic,strong) UIImageView  * contenImage;
@property(nonatomic,assign) CGSize  size;
@property(nonatomic,strong) UILabel  *nameLabel;
@property(nonatomic,strong) UIImageView  *lineImg;
@property (nonatomic, strong)MinePublishModel *model;
- (void)setModel:(MinePublishModel *)model;
@end

NS_ASSUME_NONNULL_END
