//
//  WriteCommentView.m
//  yuyue
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 edz. All rights reserved.
//

#import "WriteCommentView.h"

@implementation WriteCommentView
//@property(nonatomic,strong) UIButton  *likeBtn;
//@property(nonatomic,strong) UIButton  *giftBtn;
//@property(nonatomic,strong) UIButton  *wxBtn;
- (UIButton *)likeBtn
{
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithNormalImage:@"白色点赞" highlightedImage:@"已点赞" addTarget:self action:@selector(onClick:)];
    }
    return _likeBtn;
}
- (UIButton *)giftBtn
{
    if (!_giftBtn) {
        _giftBtn = [UIButton buttonWithNormalImage:@"礼物" highlightedImage:@"礼物" addTarget:self action:@selector(onClick:)];
    }
    return _giftBtn;
}
- (UIButton *)wxBtn
{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithNormalImage:@"分 享" highlightedImage:@"分 享" addTarget:self action:@selector(onClick:)];
    }
    
    return _wxBtn;
}
- (CustomSearchView *)commentField
{
    if (!_commentField) {
        _commentField = [[CustomSearchView alloc] init];
        self.commentField.searchImage.image = [UIImage imageNamed:@"评论"];
        self.commentField.textSearchField.placeholder = @"写评论";
        
    }
    return _commentField;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    [self addSubview:self.wxBtn];
    [self addSubview:self.giftBtn];
    [self addSubview:self.likeBtn];
    [self addSubview:self.commentField];
    [self updateConstraintsForView];
}
-(void)updateConstraintsForView
{
    CGSize size = self.wxBtn.currentImage.size;
    [self.wxBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-25);
        make.right.equalTo(-20);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    size = self.giftBtn.currentImage.size;
    [self.giftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-25);
        make.right.equalTo(self.wxBtn.left).offset(-15);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    size = self.likeBtn.currentImage.size;
    [self.likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-25);
        make.right.equalTo(self.giftBtn.left).offset(-15);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    self.commentField.layer.masksToBounds = YES;
    self.commentField.layer.cornerRadius = 5;
    self.commentField.backgroundColor = RGBA(239, 239, 239, 1);
    [self.commentField makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-(25-size.height/2));
        make.right.equalTo(self.likeBtn.left).offset(-5);
        make.height.equalTo(34);
        make.left.equalTo(15);
    }];
}
@end
