//
//  MinePublishModel.h
//  yuyue
//
//  Created by edz on 2019/9/24.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MinePublishModel : NSObject
@property(nonatomic,strong) NSString  *filesType;
@property(nonatomic,strong) NSString  *filesPath;
@property(nonatomic,strong) NSString  *desc;
@property(nonatomic,strong) NSURL     *videoAddress;
@property(nonatomic,strong) NSString  *authorId;
@property(nonatomic,strong) NSString  *title;
@property(nonatomic,strong) NSString  *uploadTime;
@property(nonatomic,strong) NSString  *playAmount;
@property(nonatomic,strong) NSString  *likeAmount;
@property(nonatomic,strong) NSString  *filesName;
@property(nonatomic,strong) NSString  *attentionAmount;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *commentAmount;
@property(nonatomic,strong) NSString  *categoryId;
@property(nonatomic,strong) NSString  *status;
@end

NS_ASSUME_NONNULL_END
