//
//  FLYForm.h
////  Created by Tony Lee on 15/10/26.

#import <Foundation/Foundation.h>
#import "FLYFormModel.h"

@interface FLYForm : NSObject

+(FLYFormModel *)formModelWithID:(NSString *)aID;


//===========  单项选择，选项统一在plist文件管理 FLYForm.OptionSingleData.plist   ===========

/**
@param key 根据key获得选项
 **/
+(NSArray *)optionSingleDataWithKey:(NSString *)key;
/**
 @param key 根据key 、code获得单项文本
 @param code
 **/
+(NSString *)optionSingleTextWithKey:(NSString *)key andCode:(NSString *)aCode;
/**
 支持动态增加选项
 **/
+(void)addOptionSingleDataWithKey:(NSString *)key andDataArray:(NSArray *)array;


@end
