//
//  SaveSectionView.h
//  FlyFormDemo
//
//  Created by Tony Lee on 16/3/22.
//  Copyright © 2016年 刚子. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveSectionViewDelegate <NSObject>

-(void)btnAction:(UIButton *)sender;

@end

@interface SaveSectionView : UIView

@property(nonatomic,assign)id<SaveSectionViewDelegate> delegate;

@end
