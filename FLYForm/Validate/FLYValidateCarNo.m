//
//  FLYValidateCarNo.m
//  Created by Tony Lee on 15/10/26.
#import "FLYValidateCarNo.h"
#import "FLYValidateMobile.h"
#import "FLYValidateMust.h"

@implementation FLYValidateCarNo
/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    FLYValidateMust *must = [[FLYValidateMust alloc] init];
    if (![must doValidateWithCellModel:cellModel]) {
        return  YES;
    }
    NSString * regex = @"[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: cellModel.fieldValue.trim];
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
