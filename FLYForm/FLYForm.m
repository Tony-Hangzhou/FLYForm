//
//  FLYForm.m
////  Created by Tony Lee on 15/10/26.

#import "FLYForm.h"
#import "FLYFormParser.h"
static NSMutableDictionary *FORM_MODEL_DICT;
static NSMutableDictionary *OPTION_SINGLE_DICT;

@interface FLYForm()
    +(NSMutableDictionary *) optionSingleDict;
@end

@implementation FLYForm

+(FLYFormModel *)formModelWithID:(NSString *)aID{
    if (!FORM_MODEL_DICT) {
        FORM_MODEL_DICT = [FLYFormParser parseToForms];
    }
    FLYFormModel *model = FORM_MODEL_DICT[aID];
    model.bindData = Nil;
    model.bindData = [[NSMutableDictionary alloc] init];
    return model;
}

// ---------  OptionSingleData --------------

+(NSArray *)optionSingleDataWithKey:(NSString *)key{
    NSMutableArray *array = [FLYForm optionSingleDict][key];
    if (!array) {
        return Nil;
    }
    NSMutableArray *data = [NSMutableArray array];
    for (id item in array) {
        if ([item isKindOfClass:[NSString class]]) {
            [data addObject:@{@"text":(NSString *)item,@"code":@""}];
        }else{
            [data addObject:(NSDictionary *)item];
        }
    }
    return data;
}


+(NSString *)optionSingleTextWithKey:(NSString *)key andCode:(NSString *)aCode{
    if (!aCode) {
        return Nil;
    }
    
    NSString *code = [NSString stringWithFormat:@"%@",aCode];
    NSArray *array = [FLYForm optionSingleDataWithKey:key];
    for (NSDictionary *dict in array) {
        if ([dict[@"code"] isEqualToString:code]) {
            return dict[@"text"];
        }
    }
    return Nil;
}


+(void)addOptionSingleDataWithKey:(NSString *)key andDataArray:(NSArray *)array{
    [FLYForm optionSingleDict][key] = array;
}

+(NSMutableDictionary *) optionSingleDict{
    if (!OPTION_SINGLE_DICT) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"FLYForm.OptionSingleData.plist" ofType:Nil];
        OPTION_SINGLE_DICT = [NSMutableDictionary dictionaryWithContentsOfFile:file];
        if (!OPTION_SINGLE_DICT)
            OPTION_SINGLE_DICT = [NSMutableDictionary dictionary];
    
    }
    return OPTION_SINGLE_DICT;
}


@end
