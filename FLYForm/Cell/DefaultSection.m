//
//  DefaultSection.m
//  FlyFormDemo
//
//  Created by Tony Lee on 16/3/22.
//  Copyright © 2016年 刚子. All rights reserved.
//

#import "DefaultSection.h"

@implementation DefaultSection

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    if(!self)
        return Nil;
    self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    return self;
}

@end
