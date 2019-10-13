//
//  CustomSearchView.m
//  yuyue
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CustomSearchView.h"

@implementation CustomSearchView
- (UIImageView *)searchImage
{
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc] init];
        _searchImage.image = [UIImage imageNamed:@"放大镜"];
        
    }
    return _searchImage;
}
- (UITextField *)textSearchField
{
    if (!_textSearchField) {
        _textSearchField = [UITextField textFieldWithFrame:CGRectZero backgroundColor:RGBA(239, 239, 239, 1) placeholder:@"搜明星、演出" clearsOnBeginEditing:YES andDelegate:self];
        _textSearchField.font = [UIFont fontWithName:@"PingFang SC" size: 15];
       _textSearchField.textColor = RGBA(188, 188, 188, 1);
    }
    return _textSearchField;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    [self addSubview:self.searchImage];
    [self addSubview:self.textSearchField];
    [self updateConstraintsForView];
}
//设置样式
- (void)updateConstraintsForView
{
    CGSize size = self.searchImage.image.size;
    [self.searchImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(13);
        make.size.equalTo(CGSizeMake(size.width, size.height));
    }];
    [self.textSearchField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchImage.centerY);
        make.left.equalTo(self.searchImage.right).offset(8);
        make.right.equalTo(0);
        make.height.equalTo(15);
    }];
}
@end
