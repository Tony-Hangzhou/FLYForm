//
//  FLYValidateMust.m
//  Created by Tony Lee on 15/10/26.

#import "FLYValidateMust.h"

@implementation FLYValidateMust


/**
 字段验证
 **/
-(BOOL)doValidateWithCellModel:(FLYCellModel *)cellModel{
    return cellModel.fieldValue && cellModel.fieldValue.trim.length>0;
}

/**
 字段设置
 **/
-(void)setup:(FLYCellModel *)cellModel andField:(id)aField{
    /**
    UIView *field = aField;
    
    UILabel *alertLabel = [UILabel new];
    alertLabel.text=@"*";
    alertLabel.textColor=[UIColor redColor];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.font = [UIFont systemFontOfSize:14.];
    CGSize labelSize = [alertLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.],NSFontAttributeName, nil]];
    
    if ([field isKindOfClass:[UITableViewCell class]]) {
        [field addSubview:alertLabel];
        [alertLabel makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(field.centerY);
            make.height.equalTo(labelSize.height);
            make.width.equalTo(labelSize.width);
            make.right.equalTo(field.right).offset(-2);
        }];
    }else{
        UIView *parentView = [field superview];
        [parentView addSubview:alertLabel];
        [alertLabel makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(field.right);
            make.centerY.equalTo(parentView.centerY);
            make.height.equalTo(labelSize.height);
            make.right.equalTo(parentView.right);
        }];
    }**/

}

/**
 错误信息
 **/
-(NSString *)errorMsgWithCellModel:(FLYCellModel *)cellModel{
    return  [NSString stringWithFormat:@"'%@'不能为空",cellModel.title];
}



@end
