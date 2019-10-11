//
//  VideoModel.m
//  yuyue
//
//  Created by edz on 2019/10/8.
//  Copyright © 2019 edz. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description",@"videoId":@"id"};
}
@end
