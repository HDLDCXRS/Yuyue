//
//  SpeedModel.h
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpeedModel : NSObject
@property(nonatomic,strong) NSString  *desc; //描述
@property(nonatomic,strong) NSURL   * url;   //图片地址
@property(nonatomic,strong) NSString  *categoryNo; //分类
@property(nonatomic,strong) NSString  *id;  //
@property(nonatomic,strong) NSString  *uploadTime;
@property(nonatomic,strong) NSString  *category; 
@end

NS_ASSUME_NONNULL_END
