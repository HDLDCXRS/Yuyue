//
//  MainADCell.m
//  yuYue
//
//  Created by edz on 2019/8/6.
//  Copyright © 2019 edz. All rights reserved.
//

#import "MainADCell.h"

@implementation MainADCell
-(void)setModel:(MainADModel * _Nonnull)model
{
    [_mainImage sd_setImageWithURL:model.url];
}

@end
