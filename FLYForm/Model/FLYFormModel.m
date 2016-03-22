//
//  FLYFormModel.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormModel.h"
#import "FLYSectionModel.h"
#import "FLYCellModel.h"
#import "FLYFormValidatorProtocol.h"

@implementation FLYFormModel


-(NSString *)doValidate{
    NSString *msg;
    NSMutableArray *array = self.sectionModelArray;
    for (FLYSectionModel *sectionModel in array) {
        for (FLYCellModel *cellModel in sectionModel.cellModelArray) {
            for (NSString *cls in cellModel.validateClassArray) {
                Class class = NSClassFromString(cls);
                if ([class conformsToProtocol:@protocol(FLYFormValidatorProtocol)]) {
                    id<FLYFormValidatorProtocol> validate = [[class alloc] init];
                    if(![validate doValidateWithCellModel:cellModel]){
                        NSString *error = [validate errorMsgWithCellModel:cellModel];
                        if (!msg) {
                            msg = error;
                        }else{
                            msg = [NSString stringWithFormat:@"%@\n%@",msg,error];
                        }
                        break;
                    }
                }
            }
        }
    }
    return msg;
}


-(FLYCellModel *)cellModelWithKey:(NSString *)key sectionIndex:(int)aIndex{
    FLYSectionModel *sectionModel = self.sectionModelArray[aIndex];
    for (FLYCellModel *cellModel in sectionModel.cellModelArray) {
        if ([cellModel.key isEqualToString:key]) {
            return cellModel;
        }
    }
    return Nil;
}


-(void)removeCellModelWithKey:(NSString *)key sectionIndex:(int)aIndex{
    FLYSectionModel *sectionModel = self.sectionModelArray[aIndex];
    for (FLYCellModel *cellModel in sectionModel.cellModelArray) {
        if ([cellModel.key isEqualToString:key]) {
            [sectionModel.cellModelArray removeObject:cellModel];
            break;
        }
    }
}


-(void)insertCellModel:(FLYCellModel *)aCellModel afterForKey:(NSString *)key sectionIndex:(int)aIndex{
    FLYSectionModel *sectionModel = self.sectionModelArray[aIndex];
    aCellModel.sectionModel = sectionModel;
    int i=0;
    for (FLYCellModel *cellModel in sectionModel.cellModelArray) {
        if ([cellModel.key isEqualToString:key]) {
            [sectionModel.cellModelArray insertObject:aCellModel atIndex:i+1];
            break;
        }
        i++;
    }
}


@end
