//
//  XJNumCell.m
//  Created by Tony Lee on 15/10/26.

#import "XJNumCell.h"

@implementation XJNumCell


-(void)setUp{
    
    [super setUp];
    
    // 创建对象
    _numBtn = [[HJCAjustNumButton alloc] init];
    _numBtn.textField.text = self.cellModel.fieldValue;
    // 加到父控件上
    [self.contentView addSubview:_numBtn];
    
    [_numBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(100);
        make.height.equalTo(25);
    }];
    __weak typeof (self) weakSelf = self;
    self.numBtn.callBack = ^(NSString *currentNum){
        weakSelf.cellModel.fieldValue = currentNum;
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(valueChangeForFLYCellModel:)]) {
            [weakSelf.delegate valueChangeForFLYCellModel:weakSelf.cellModel];
        }
    };
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
