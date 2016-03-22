//
//  FLYCellModel.m
////  Created by Tony Lee on 15/10/26.

#import "FLYCellModel.h"

@implementation FLYCellModel

-(NSString *)placeholder{
    if (_placeholder && [_placeholder isEqualToString:@"auto"]) {
        NSString *s = [self.cellClass contains:@"PickerCell"] ? @"选择" : @"输入";
        return [NSString stringWithFormat:@"请%@%@",s, self.title];
    }
    return _placeholder;
}

-(NSArray *)validateClassArray{
    NSMutableArray *array = [NSMutableArray array];
    NSString *cls = self.validateClass;
    if (!cls || cls.trim.length==0)
        return Nil;
    for (NSString *s in [cls split:@","]) {
        if (s.trim.length==0) continue;
        [array addObject:s];
    }
    return array;
}

-(void)setFieldValue:(NSString *)value{
    self.sectionModel.formModel.bindData[self.key] = value;
}

-(NSString *)fieldValue{
    return self.sectionModel.formModel.bindData[self.key];
}

-(void)setFieldValueCodes:(NSArray *)valueCodes{
    NSString *key = [NSString stringWithFormat:@"%@Codes",self.key];
    self.sectionModel.formModel.bindData[key] = valueCodes;
}

-(NSArray *)fieldValueCodes{
    NSString *key = [NSString stringWithFormat:@"%@Codes",self.key];
    return self.sectionModel.formModel.bindData[key];
}


-(void)setFieldValueTexts:(NSArray *)valueTexts{
    NSString *key = [NSString stringWithFormat:@"%@Texts",self.key];
    self.sectionModel.formModel.bindData[key] = valueTexts;
}

-(NSArray *)fieldValueTexts{
    NSString *key = [NSString stringWithFormat:@"%@Texts",self.key];
    return self.sectionModel.formModel.bindData[key];
}



+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell{
     return [FLYCellModel createWithKey:aKey title:aTitle cellClass:aCell validateClass:Nil placeholder:Nil];
}

+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell placeholder:(NSString *)pHolder{
    return [FLYCellModel createWithKey:aKey title:aTitle cellClass:aCell validateClass:Nil placeholder:pHolder];
}

+(instancetype) createWithKey:(NSString *)aKey title:(NSString *)aTitle cellClass:(NSString *)aCell validateClass:(NSString *)vCls placeholder:(NSString *)pHolder{
    FLYCellModel *model = [[FLYCellModel alloc] init];
    model.key = aKey;
    model.title = aTitle;
    model.cellClass = aCell;
    model.validateClass = vCls;
    model.placeholder = pHolder;
    return model;
    
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未知的FLYForm.xml属性：%@",key);
}

@end
