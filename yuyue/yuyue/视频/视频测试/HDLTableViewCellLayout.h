//
//  HDLTableViewCellLayout.h
//  yuyue
//
//  Created by edz on 2019/9/4.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDLTableData.h"
NS_ASSUME_NONNULL_BEGIN
@interface HDLTableViewCellLayout : NSObject
@property(nonatomic,strong) HDLTableData  *data;
@property (nonatomic, readonly) CGRect headerRect; //头像位置
@property (nonatomic, readonly) CGRect nickNameRect; //头像名位置
@property (nonatomic, readonly) CGRect videoRect;  //视频位置
//@property(nonatomic,readonly)   CGRect  *;
@property (nonatomic, readonly) CGRect playBtnRect; //播放按钮位置
@property (nonatomic, readonly) CGRect titleLabelRect; //标题文字位置
@property (nonatomic, readonly) CGRect maskViewRect;  //
@property (nonatomic, readonly) CGFloat height;  //高度
@property (nonatomic, readonly) BOOL isVerticalVideo; //是否水平
-(instancetype)initWithData:(HDLTableData*)data;
@end

NS_ASSUME_NONNULL_END
