//
//  SexPickerTool.m
//  PickerView
//
//  Created by  zengchunjun on 2017/4/20.
//  Copyright © 2017年  zengchunjun. All rights reserved.
//

#import "SexPickerTool.h"

@interface SexPickerTool ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic,strong) NSArray  *dataSource;
@property (nonatomic,copy)NSString *sexPick;


@end

@implementation SexPickerTool
- (instancetype)initWithFrame:(CGRect)frame DataSorce:(NSArray *)data
{
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"SexPickerTool" owner:nil options:nil]firstObject];
        _dataSource = data;
        self.sexPick = self.dataSource[0];
    }
    self.frame = frame;
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.pickerView.showsSelectionIndicator = YES;
    
}

- (IBAction)pickDone:(UIButton *)sender {
    self.callBlock(self.sexPick);
}


- (IBAction)pickCancel:(UIButton *)sender {
    self.callBlock(nil);
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"%@",self.dataSource[row]);
    self.sexPick = self.dataSource[row];
}

@end
