//
//  ShowSiteModel.h
//  yuyue
//
//  Created by edz on 2019/9/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowSiteModel : NSObject
@property(nonatomic,strong) NSURL  *imageUrl;
@property(nonatomic,strong) NSString  *admissionTime;
@property(nonatomic,strong) NSString  *personTotal;
@property(nonatomic,strong) NSString  *startTime;
@property(nonatomic,strong) NSString  *id;
@property(nonatomic,strong) NSString  *title;
@property(nonatomic,strong) NSString  *siteAddr;
@property(nonatomic,strong) NSString  *personSum;
@end

NS_ASSUME_NONNULL_END
