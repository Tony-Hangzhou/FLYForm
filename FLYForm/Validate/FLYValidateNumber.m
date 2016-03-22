//
//  FLYValidateNumber.m
//  Created by Tony Lee on 15/10/26.

#import "FLYValidateNumber.h"
#import "FLYValidateMobile.h"
#import "FLYValidateMust.h"
@implementation FLYValidateNumber
/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    FLYValidateMust *must = [[FLYValidateMust alloc] init];
    if (![must doValidateWithCellModel:cellModel]) {
        return  YES;
    }
    NSString * regex = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: cellModel.fieldValue.trim];
}

/**
 错误信息
 **/
-(NSString *)errorMsgWithCellModel:(FLYCellModel *)cellModel{
    return  [NSString stringWithFormat:@"'%@'只能为数字格式",cellModel.title];
}

-(void)setup:(FLYCellModel *)cellModel andField:(id)aField{
}



@end
