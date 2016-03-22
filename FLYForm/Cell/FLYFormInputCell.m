//
//  FLYFormInputCell.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormInputCell.h"
#import "FLYFormValidatorProtocol.h"

@implementation FLYFormInputCell

-(void)setUp{
    
    self.textLabel.text = self.cellModel.title;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor colorWithHex:0x999999];
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.inputField.placeholder=self.cellModel.placeholder ;
    self.inputField.delegate=self;

    if (self.cellModel.validateClass) {
        if ([self.cellModel.validateClass contains:@"FLYValidateNumber"]) {
            self.inputField.keyboardType = UIKeyboardTypeNumberPad;
        }else if ([self.cellModel.validateClass contains:@"FLYValidateDecimals"]){
            self.inputField.keyboardType = UIKeyboardTypeDecimalPad;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self.inputField];
    if (self.cellModel.fieldValue) {
        self.inputField.text = self.cellModel.fieldValue;
    }
    self.inputField.font = [UIFont systemFontOfSize:14];
    self.inputField.textAlignment = NSTextAlignmentRight;
    self.inputField.textColor = [UIColor colorWithHex:0x333333];
    self.inputField.placeholder = self.cellModel.placeholder;
    if([self.cellModel.title isEqualToString:@"密        码"]|| [self.cellModel.title isEqualToString:@"确认密码"]|| [self.cellModel.title isEqualToString:@"密    码"]){
        self.inputField.secureTextEntry = YES;
    }

    [self.contentView addSubview:self.inputField];
    __weak typeof (self) weakSelf = self;
    [self.inputField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.centerY);
        if (!weakSelf.cellModel.title || weakSelf.cellModel.title.trim.length==0) {
            make.left.equalTo(weakSelf.left).offset(15);
        }else{
            make.left.equalTo(weakSelf.left).offset(10);
        }
        make.right.equalTo(weakSelf.right).offset(-10);
        make.height.equalTo(weakSelf.height).offset(-10);
    }];

    
}
- (void)textDidChange{
    self.cellModel.fieldValue = self.inputField.text;
    //NSLog(@"%@",self.cellModel.fieldValue);
    if ([self.delegate respondsToSelector:@selector(valueChangeForFLYCellModel:)]) {
        [self.delegate valueChangeForFLYCellModel:self.cellModel];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
