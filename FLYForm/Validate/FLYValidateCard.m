//
//  FLYValidateCard.m
//  Created by Tony Lee on 15/10/26.

#import "FLYValidateCard.h"

#import "FLYValidateMobile.h"
#import "FLYValidateMust.h"

@implementation FLYValidateCard


/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    FLYValidateMust *must = [[FLYValidateMust alloc] init];
    if (![must doValidateWithCellModel:cellModel]) {
        return  YES;
    }
    NSString * regex = @"^\\d{15}(\\d\\d[0-9xX])?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: cellModel.fieldValue];
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
