//
//  BassInformationTableViewCell.h
//  yuYue
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomerModel.h"
NS_ASSUME_NONNULL_BEGIN
//设置一个代理，用于将textField中d输入的值传递到Ccontroller中去处理
//@protocol CustomerCellDelegate <NSObject>
//@optional
//- (void)textFieldCellText:(NSString *)text index:(NSIndexPath *)index;
//@end
@interface BassInformationTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel  * titlleLabel;
@property(nonatomic,strong) UITextField  *inputTextField;
@property(nonatomic,copy) void (^saveData)(NSString *text);

@end

NS_ASSUME_NONNULL_END
