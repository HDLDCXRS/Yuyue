//
//  PublisjTableViewCell.h
//  yuyue
//
//  Created by edz on 2019/9/2.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublisjTableViewCell : UITableViewCell
@property(nonatomic,strong) UITextField  *titleTextField;  //输入标题
@property(nonatomic,strong) UILabel  *countLabel;    //字数计算

@end

NS_ASSUME_NONNULL_END
