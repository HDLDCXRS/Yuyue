//
//  RechangCommonBtn.h
//  yuyue
//
//  Created by edz on 2019/9/16.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RechangCommonBtn : UIButton
@property(nonatomic,strong) UIImageView  *pictureImg;
@property(nonatomic,strong) UILabel  *countZSLabel;
@property(nonatomic,strong) UILabel  *moneyLabel;
-(instancetype)initWithFrame:(CGRect)frame  ZSCount:(NSString*)count MoneyCount:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
