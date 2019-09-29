//
//  CheckCode.m
//  yuyue
//
//  Created by edz on 2019/9/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "CheckCode.h"

@implementation CheckCode
//校验身份证
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString postUIViewController:(UIViewController *)vc
{
    
    if (identityString.length != 18)
    {
        UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"身份证号输入不够18位" andCancelInfo:@"确定"];
        [vc presentViewController:alter animated:YES completion:^{}];
        return NO;
        
    }
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString])
        
    {
        UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"身份证号格式不正确" andCancelInfo:@"确定"];
        [vc presentViewController:alter animated:YES completion:^{}];
         return NO;
    }
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"身份证号无效" andCancelInfo:@"确定"];
            [vc presentViewController:alter animated:YES completion:^{}];
             return NO;
            
        }
    }
    
    return YES;
    
}
+ (BOOL) validateMobile:(NSString *)mobileNum postUIViewController:(UIViewController *)vc {
    /**
     * 手机号码
     * 移动：134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
     * 联通：130/131/132/155/156/185/186/145/176
     * 电信：133/153/180/181/189/177
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8]/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130/131/132/152/155/156/185/186/145/176
     */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56]|45|76)\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133/153/180/181/189/177
     */
    NSString *CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES) ||
        ([regextestcm evaluateWithObject:mobileNum] == YES) ||
        ([regextestct evaluateWithObject:mobileNum] == YES) ||
        ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        UIAlertController *alter = [UIAlertController alertCancelWithTitle:@"提示信息" andMessage:@"手机号输入错误" andCancelInfo:@"确定"];
        [vc presentViewController:alter animated:YES completion:^{}];
        return NO;
    }
}
+ (BOOL) validatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
}
@end
