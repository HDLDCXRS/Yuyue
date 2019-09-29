//
//  LoginModel.h
//  yuyue
//
//  Created by edz on 2019/9/3.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject
@property(nonatomic,assign)  double income;
@property(nonatomic,strong) NSString  * jpushName;
@property(nonatomic,strong) NSString  *userStatus;
@property(nonatomic,strong) NSString  *salt;
@property(nonatomic,strong) NSString  *nickName;
@property(nonatomic,strong) NSString  *userNo;
@property(nonatomic,strong) NSString  *sex;
@property(nonatomic,strong) NSString  *commentTotal;
@property(nonatomic,strong) NSString  *updateTime;
@property(nonatomic,strong) NSString  *attentionTotal;
@property(nonatomic,strong) NSString  *likeTotal;
@property(nonatomic,strong) NSString  *realName;
@property(nonatomic,strong) NSString  *password;
@property(nonatomic,assign) double    total;
@property(nonatomic,strong) NSString  *createTime;
@property(nonatomic,strong) NSString  *phone;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *userType;
@property(nonatomic,strong) NSString  *opendId;
@property(nonatomic,strong) NSURL  *headpUrl;
@end

NS_ASSUME_NONNULL_END
