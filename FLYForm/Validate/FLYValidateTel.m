//
//  FLYValidateTel.m
//  Created by Tony Lee on 15/10/26.

#import "FLYValidateTel.h"


#import "FLYValidateMobile.h"
#import "FLYValidateMust.h"

@implementation FLYValidateTel


/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    FLYValidateMust *must = [[FLYValidateMust alloc] init];
    if (![must doValidateWithCellModel:cellModel]) {
        return  YES;
    }
    NSString * regex = @"^(\\d{4}-|\\d{3}-)?(\\d{8}|\\d{7})$";
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
