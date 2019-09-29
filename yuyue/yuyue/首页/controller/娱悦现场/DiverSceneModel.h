//
//  DiverSceneModel.h
//  yuyue
//
//  Created by edz on 2019/9/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiverSceneModel : NSObject
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSURL  *imageUrl;
@property(nonatomic,copy) NSString  *siteAddr;
@property(nonatomic,copy) NSString  *personTotal;
@property(nonatomic,copy) NSString  *personSum;
@property(nonatomic,copy) NSString  *admissionTime;
@property(nonatomic,copy) NSString  *startTime;
//@property(nonatomic,copy) NSString  *locationImg;
//@property(nonatomic,strong) DiverSceneModel  *model;
@end

NS_ASSUME_NONNULL_END
