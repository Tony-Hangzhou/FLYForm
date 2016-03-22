//
//  FLYSectionModel.h
//  Created by Tony Lee on 15/10/26.

#import <Foundation/Foundation.h>
#import "FLYFormModel.h"

@interface FLYSectionModel : NSObject

@property(nonatomic,strong) NSString *headerClass;
@property(nonatomic,strong) NSString *footerClass;

@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) NSMutableArray *cellModelArray;
@property(nonatomic,assign) FLYFormModel *formModel;

@end
