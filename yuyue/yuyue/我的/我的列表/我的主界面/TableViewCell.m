//
//  TableViewCell.m
//  yuYue
//
//  Created by edz on 2019/8/7.
//  Copyright © 2019 edz. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        _imgView.image = [UIImage imageNamed:@"广告推广"];
        CGSize size = _imgView.image.size;
        [_imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.width.equalTo(size.width);
            make.left.equalTo(16);
            make.height.equalTo(size.height);
        }];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size: 15];
        _titleLabel.textColor = RGBA(41, 43, 50, 1);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.left.equalTo(self.imgView.right).offset(13);
            make.width.equalTo(100);
            make.height.equalTo(14);
        }];
    }
    return self;
}

@end
