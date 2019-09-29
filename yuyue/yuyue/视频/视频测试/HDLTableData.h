//
//  HDLTableData.h
//  yuyue
//
//  Created by edz on 2019/9/4.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDLTableData : NSObject
@property (nonatomic, copy) NSString *nick_name;//标题名字
@property (nonatomic, copy) NSString *head; //头像
@property (nonatomic, assign) NSInteger agree_num;  //评论
@property (nonatomic, assign) NSInteger share_num;  //分享
@property (nonatomic, assign) NSInteger post_num;  //转发
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat thumbnail_width; //缩略图宽度
@property (nonatomic, assign) CGFloat thumbnail_height; // 缩略图高度
@property (nonatomic, assign) CGFloat video_duration; //视屏时间
@property (nonatomic, assign) CGFloat video_width; //视频宽度
@property (nonatomic, assign) CGFloat video_height; // 视屏高度
@property (nonatomic, copy) NSString *thumbnail_url;
@property (nonatomic, copy) NSString *video_url;  //视频地址
@end

NS_ASSUME_NONNULL_END
