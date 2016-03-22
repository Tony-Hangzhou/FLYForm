//
//  FLYFormPickerCell.h
//  Created by Tony Lee on 15/10/26.

#import "FLYTableViewCell.h"
#import "FLYFormGeneralCell.h"

@interface FLYFormPickerCell : FLYFormGeneralCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@end
