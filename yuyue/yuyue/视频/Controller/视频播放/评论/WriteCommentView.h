//
//  WriteCommentView.h
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WriteCommentView : UIView
@property(nonatomic,strong) UIButton  *likeBtn;
@property(nonatomic,strong) UIButton  *giftBtn;
@property(nonatomic,strong) UIButton  *wxBtn;
@property(nonatomic,strong) CustomSearchView  *commentField;
@end

NS_ASSUME_NONNULL_END
