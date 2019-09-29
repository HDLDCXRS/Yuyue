//
//  VideoTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/4.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDLTableViewCellLayout.h"
#import "HDLTableData.h"
NS_ASSUME_NONNULL_BEGIN
@protocol VideoTableViewCellDelegate <NSObject>
-(void)hdl_playTheVideoAtIndexPath:(NSIndexPath *)indexPath; //播放视频记录是第几个
@end
@interface VideoTableViewCell : UITableViewCell
@property(nonatomic,strong) HDLTableViewCellLayout  *layout;
@property (nonatomic, copy) void(^playCallback)(void);
- (void)setDelegate:(id<VideoTableViewCellDelegate>)delegate withIndexPath:(NSIndexPath *)indexPath;

- (void)showMaskView;

- (void)hideMaskView;

- (void)setNormalMode;
@end

NS_ASSUME_NONNULL_END
