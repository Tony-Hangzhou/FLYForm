//
//  FLYFormModel.h
//  Created by Tony Lee on 15/10/26.

#import <Foundation/Foundation.h>
@class FLYCellModel;

@interface FLYFormModel : NSObject

@property(nonatomic,strong) NSString *formID;
@property(nonatomic,strong) NSMutableArray *sectionModelArray;
@property(nonatomic,strong) NSMutableDictionary *bindData;//绑定数据的Dict

//验证表单
-(NSString *)doValidate;

//查询CellModel
-(FLYCellModel *)cellModelWithKey:(NSString *)key sectionIndex:(int)aIndex;

//根据Key删除cell
-(void)removeCellModelWithKey:(NSString *)key sectionIndex:(int)aIndex;

//插入CellModel，在指定的Key单元格之后
-(void)insertCellModel:(FLYCellModel *)cellModel afterForKey:(NSString *)key sectionIndex:(int)aIndex;

@end
