//
//  WithdrawalRecordModel.h
//  yuyue
//
//  Created by edz on 2019/9/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalRecordModel : NSObject
@property(nonatomic,strong) NSString  *realName;
@property(nonatomic,assign) double  money;
@property(nonatomic,strong) NSString  *merchantId;
@property(nonatomic,strong) NSString  *completeTime;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *outNo;
@property(nonatomic,strong) NSString  *responseMessage;
@property(nonatomic,strong) NSString  *tradeType;
@property(nonatomic,strong) NSString  *moneyNumber;
@property(nonatomic,strong) NSString  *responseCode;
@property(nonatomic,strong) NSString  *status;
@end

NS_ASSUME_NONNULL_END
