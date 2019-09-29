//
//  MyAdvertiserModel.h
//  yuyue
//
//  Created by edz on 2019/9/17.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAdvertiserModel : NSObject
@property(nonatomic,strong) NSURL  *adImageUrl;
@property(nonatomic,strong) NSURL  *payUrl;
@property(nonatomic,strong) NSString  *commodityId;
@property(nonatomic,strong) NSString  *commodityPrice;
@property(nonatomic,strong) NSString  *applicationTime;
@property(nonatomic,strong) NSString  *merchantId;
@property(nonatomic,strong) NSString  *spokesPersonId;
@property(nonatomic,strong) NSString  *addr;
@property(nonatomic,strong) NSString  *category;
@property(nonatomic,strong) NSString  *priceId;
@property(nonatomic,strong) NSString  *adWord;
@property(nonatomic,strong) NSString  *commodityName;
@property(nonatomic,strong) NSString  *status;
@end

NS_ASSUME_NONNULL_END
