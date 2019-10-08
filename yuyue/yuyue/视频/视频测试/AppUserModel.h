//
//  AppUserModel.h
//  yuyue
//
//  Created by edz on 2019/10/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUserModel : NSObject
@property(nonatomic,strong) NSURL  *headpUrl;
@property(nonatomic,strong) NSString  *nickName;
@property(nonatomic,strong) NSString  *commentTotal;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *attentionTotal;
@property(nonatomic,strong) NSString  *likeTotal;

@end

NS_ASSUME_NONNULL_END
