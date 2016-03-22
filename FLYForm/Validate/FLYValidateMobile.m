//
//  FLYValidateMobile.m
//  Created by Tony Lee on 15/10/26.

#import "FLYValidateMobile.h"
#import "FLYValidateMust.h"

@implementation FLYValidateMobile

/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    FLYValidateMust *must = [[FLYValidateMust alloc] init];
    if (![must doValidateWithCellModel:cellModel]) {
        return  YES;
    }
    NSString * regex = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: cellModel.fieldValue.trim];
}


-(BOOL)doValidateWithMobile:(NSString *)mobile{
    NSString * regex = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: mobile.trim];
}

/**
 错误信息
 **/
-(NSString *)errorMsgWithCellModel:(FLYCellModel *)cellModel{
    return  [NSString stringWithFormat:@"'%@'格式不正确",cellModel.title];
}

-(void)setup:(FLYCellModel *)cellModel andField:(id)aField{
    
}


@end
