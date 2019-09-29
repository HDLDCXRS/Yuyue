//
//  SpeedView.h
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(NSInteger index);
@interface SpeedView : UIView

@property (nonatomic,strong) NSArray * dataSourse ;  // 数据源
@property (nonatomic,copy) ClickBlock clickBlock ;
@end

NS_ASSUME_NONNULL_END
