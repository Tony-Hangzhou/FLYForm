//
//  FLYCellModel.h

//  Created by Tony Lee on 15/10/23.
//

#import <Foundation/Foundation.h>
#import "FLYSectionModel.h"

@interface FLYCellModel : NSObject

@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *cellClass;
@property(nonatomic,strong) NSString *validateClass;
@property(nonatomic,strong) NSString *placeholder;
@property(nonatomic,strong) NSString *icon;

@property(nonatomic,strong) NSString *optionsData;//选项类字段的数据源，单项选择支持 a,b,c 格式，支持文件@文件名
@property(nonatomic,strong) id optionsDataDynamic;//动态数据源

@property(nonatomic,strong) NSString *forwardController;//转向下一个Controller类
@property(nonatomic,assign) FLYSectionModel *sectionModel;
@property(nonatomic,assign) NSString *fieldValue;//实际上操作的是FLYFormModel的bindData，级联一般为符号/分割后的值，如：浙江省/杭州市
@property(nonatomic,assign) NSArray *fieldValueCodes;//支持编码方式的值，因为是级联，所以值是数组。比如：FLYFormPickerCell2
@property(nonatomic,assign) NSArray *fieldValueTexts;

-(NSArray *)validateClassArray;//转换验证类为Array

/**
 用精简属性，创建FLYCellModel
 **/
+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell;

/**
 用精简属性 + placeholder，创建FLYCellModel
 **/
+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell placeholder:(NSString *)pHolder;

/**
 用所有属性，创建FLYCellModel
 **/
+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell validateClass:(NSString *)vCls placeholder:(NSString *)pHolder;


@end
