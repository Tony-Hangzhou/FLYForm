//
//  SaveSectionView.m
//  FlyFormDemo
//
//  Created by Tony Lee on 16/3/22.
//  Copyright © 2016年 刚子. All rights reserved.
//

#import "SaveSectionView.h"

@implementation SaveSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    if(!self)
        return Nil;
    self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];

    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame=CGRectZero;
    [confirmBtn setBackgroundColor:[UIColor colorWithRed:8/255.0f green:150/255.0f blue:62/255.0f alpha:1]];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"保存" forState:UIControlStateNormal];

    [self addSubview:confirmBtn];
    
    [confirmBtn makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(15);
        make.right.equalTo(self.right).offset(-15);
    }];
    
    return self;
}

-(void)confirmBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnAction:)]) {
        [self.delegate btnAction:btn];
    }
}

@end
