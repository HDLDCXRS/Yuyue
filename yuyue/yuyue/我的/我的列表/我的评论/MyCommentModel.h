//
//  MyCommentModel.h
//  yuyue
//
//  Created by edz on 2019/9/24.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCommentModel : NSObject
@property(nonatomic,strong) NSString  *createTime;
@property(nonatomic,strong) NSString  *headUrl;
@property(nonatomic,strong) NSString  *videoId;
@property(nonatomic,strong) NSString  *ida;
@property(nonatomic,strong) NSString  *text;
@property(nonatomic,strong) NSString  *userName;
@property(nonatomic,strong) NSString  *userId;
@end

NS_ASSUME_NONNULL_END
