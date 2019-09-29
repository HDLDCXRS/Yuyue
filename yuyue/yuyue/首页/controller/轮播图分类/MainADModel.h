//
//  MainADModel.h
//  yuyue
//
//  Created by edz on 2019/9/18.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainADModel : NSObject
@property(nonatomic,strong) NSString  * name;
@property(nonatomic,strong) NSString  * description;
@property(nonatomic,strong) NSString  * id;
@property(nonatomic,strong) NSString  * uploadTime;
@property(nonatomic,strong) NSURL  * url;
@property(nonatomic,strong) NSString  * status;
@end

NS_ASSUME_NONNULL_END
