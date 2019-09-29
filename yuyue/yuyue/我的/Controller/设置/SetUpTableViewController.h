//
//  SetUpTableViewController.h
//  yuYue
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^StateBlock)(int count);
@interface SetUpTableViewController : UIViewController
@property(nonatomic,strong) UIButton  *exitBtn;
@property(nonatomic,copy) StateBlock  click;
@end

NS_ASSUME_NONNULL_END
