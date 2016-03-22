//
//  FLYFormInputCell.h
//  Created by Tony Lee on 15/10/26.

#import "FLYFormGeneralCell.h"

@interface FLYFormInputCell : FLYTableViewCell<UITextFieldDelegate>

@property(nonatomic,strong)UITextField * inputField;

@end
