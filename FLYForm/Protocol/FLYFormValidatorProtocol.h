//
//  FLYFormValidatorProtocol.h
//  Created by Tony Lee on 15/10/26.

#import <Foundation/Foundation.h>
#import "FLYCellModel.h"

@protocol FLYFormValidatorProtocol <NSObject>

/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel;

/**
 字段设置
 **/
-(void)setup:(FLYCellModel *)cellModel andField:(id)aField;

/**
 错误信息
 **/
-(NSString *)errorMsgWithCellModel:(FLYCellModel *)cellModel;

@end
