//
//  ModifyPhoneViewController.h
//  yuYue
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyPhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FinishBtn;

@end

NS_ASSUME_NONNULL_END
