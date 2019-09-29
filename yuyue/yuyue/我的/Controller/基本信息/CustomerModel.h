//
//  CustomerModel.h
//  yuYue
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerModel : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSIndexPath *index;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
