//
//  CustomerModel.m
//  yuYue
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CustomerModel.h"

@implementation CustomerModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _text = dict[@"text"];
        _index = dict[@"index"];
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
