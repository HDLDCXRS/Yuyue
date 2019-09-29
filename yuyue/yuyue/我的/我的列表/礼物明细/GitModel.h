//
//  GitModel.h
//  yuyue
//
//  Created by edz on 2019/9/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GitModel : NSObject
@property(nonatomic,strong) NSString  *sourceId;
@property(nonatomic,strong) NSString  *note;
@property(nonatomic,strong) NSString  *orderNo;
@property(nonatomic,strong) NSString  *mobile;
@property(nonatomic,strong) NSString  *completeTime;
@property(nonatomic,strong) NSString  *responseCode;
@property(nonatomic,strong) NSString  *money;
@property(nonatomic,strong) NSString  *merchantId;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *responseMessage;
@property(nonatomic,strong) NSString  *tradeType;
@property(nonatomic,strong) NSString  *status;
@property(nonatomic,strong) NSString  *statusCode;
@end

NS_ASSUME_NONNULL_END
