//
//  AboutOurViewController.h
//  yuyue
//
//  Created by edz on 2019/9/3.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutOurViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgcImgView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *versonLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UILabel *artLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgcFootView;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@end

NS_ASSUME_NONNULL_END
