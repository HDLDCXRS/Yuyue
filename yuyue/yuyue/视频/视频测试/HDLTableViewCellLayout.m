//
//  HDLTableViewCellLayout.m
//  yuyue
//
//  Created by edz on 2019/9/4.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HDLTableViewCellLayout.h"
#import "NSString+Size.h"
@interface HDLTableViewCellLayout()
@property (nonatomic, assign) CGRect headerRect;
@property (nonatomic, assign) CGRect nickNameRect;
@property (nonatomic, assign) CGRect videoRect;
@property (nonatomic, assign) CGRect playBtnRect;
@property (nonatomic, assign) CGRect titleLabelRect;
@property (nonatomic, assign) CGRect maskViewRect;
@property (nonatomic, assign) BOOL isVerticalVideo;
@property (nonatomic, assign) CGFloat height;
@end
@implementation HDLTableViewCellLayout

- (instancetype)initWithData:(HDLTableData *)data {
    self = [super init];
    if (self) {
        _data = data;
        
        CGFloat min_x = 0;
        CGFloat min_y = 0;
        CGFloat min_w = 0;
        CGFloat min_h = [self videoHeight];;
        CGFloat min_view_w = SCREENWIDTH;
        CGFloat margin = 10;
        //视频
        min_x = 0;
        min_y = 0;
        min_w = min_view_w;
        min_h = [self videoHeight];
        self.videoRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        //标题
        min_x =(SCREENWIDTH - CGRectGetMaxX(self.videoRect))/2 + 7;
        min_y  = 10;
        min_w = [data.title textSizeWithFont: [UIFont fontWithName:@"PingFang SC" size: 15] numberOfLines:2 lineSpacing:20 constrainedWidth:CGRectGetMaxX(self.videoRect)-37].width;
        min_h = [data.title textSizeWithFont: [UIFont fontWithName:@"PingFang SC" size: 15] numberOfLines:2 lineSpacing:20 constrainedWidth:CGRectGetMaxX(self.videoRect)-37].height;
        self.titleLabelRect = CGRectMake(min_x, min_y, min_w, min_h);
        min_x = 15;
        min_y = CGRectGetMaxY(self.videoRect)+ 7;
        min_w = 19;
        min_h = 19;
        //头像
        self.headerRect = CGRectMake(min_x, min_y, min_w, min_h);
       //头像名字
        min_x = CGRectGetMaxX(self.headerRect) + 10;
        min_y = CGRectGetMaxY(self.videoRect)+ 7;
        min_w = [data.nick_name textSizeWithFont:[UIFont systemFontOfSize:15] limitWidth:min_view_w-2*margin-min_x].width;
        min_h = 15;
        self.nickNameRect = CGRectMake(min_x, min_y, min_w, min_h);
       //播放按钮
        min_w = 44;
        min_h = min_w;
        min_x = (CGRectGetWidth(self.videoRect)-min_w)/2;
        min_y = (CGRectGetHeight(self.videoRect)-min_h)/2;
        
        self.playBtnRect = CGRectMake(min_x, min_y, min_w, min_h);
        
//        min_x = margin;
//        min_y = CGRectGetMaxY(self.videoRect) + margin;
//        min_w = CGRectGetWidth(self.videoRect) - 2*margin;
//        min_h = [data.title textSizeWithFont:[UIFont systemFontOfSize:15] numberOfLines:0 constrainedWidth:min_w].height;
//        //下面的文字
//        self.titleLabelRect = CGRectMake(min_x, min_y, min_w, min_h);
   
        
     self.height = CGRectGetMaxY(self.headerRect)+margin;
//
        min_x = 0;
        min_y = 0;
        min_w = SCREENWIDTH;
        min_h = self.height;
        self.maskViewRect = CGRectMake(min_x, min_y, min_w, 191);
        
    }
    return self;
}

- (BOOL)isVerticalVideo {
    return _data.video_width < _data.video_height;
}

- (CGFloat)videoHeight {
    CGFloat videoHeight;
    if (self.isVerticalVideo) {
        videoHeight = [UIScreen mainScreen].bounds.size.width * 0.6 * self.data.video_height/self.data.video_width *0.8;
//        videoHeight = 191;
    } else {
        videoHeight = [UIScreen mainScreen].bounds.size.width * self.data.video_height/self.data.video_width;
    }
    return videoHeight;
}

@end
