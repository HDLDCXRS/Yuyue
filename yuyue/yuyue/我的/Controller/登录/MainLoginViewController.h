//
//  MainLoginViewController.h
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock) (LoginModel * passedValue);
@interface MainLoginViewController : UIViewController
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@end

NS_ASSUME_NONNULL_END
