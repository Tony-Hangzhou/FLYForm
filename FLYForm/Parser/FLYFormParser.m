//
//  FLYFormParser.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormParser.h"
#import "TBXML.h"
#import "FLYFormModel.h"
#import "FLYSectionModel.h"
#import "FLYCellModel.h"

@interface FLYFormParser()

+(NSMutableDictionary *)parseToFormsWithFile:(NSString *)file;

@end

@implementation FLYFormParser

+(NSMutableDictionary *)parseToFormsWithFile:(NSString *)file{
    
    NSMutableDictionary *rooms = [NSMutableDictionary dictionary];
    NSError *error;
    TBXML *tbxml = [TBXML newTBXMLWithXMLFile:file error:&error];
    if(error)
        NSLog(@"加载%@异常",file);
    [TBXML iterateElementsForQuery:@"Form" fromElement:tbxml.rootXMLElement withBlock:^(TBXMLElement *element) {
        FLYFormModel *formModel = [[FLYFormModel alloc] init];
        NSError *_error;
        NSString *formID = [TBXML valueOfAttributeNamed:@"id" forElement:element error:&_error];
        formModel.formID = formID;
        
        // Section
        NSMutableArray *sectionArray = [NSMutableArray array];
        [TBXML iterateElementsForQuery:@"Section" fromElement:element withBlock:^(TBXMLElement *element) {
            FLYSectionModel *sectionModel = [[FLYSectionModel alloc] init];
            sectionModel.formModel = formModel;
            [TBXML iterateAttributesOfElement:element withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
                [sectionModel setValue:attributeValue forKey:attributeName];
            }];
            
            //Cell
            NSMutableArray *cellArray = [NSMutableArray array];
            [TBXML iterateElementsForQuery:@"Cell" fromElement:element withBlock:^(TBXMLElement *element) {
                FLYCellModel *cellModel = [[FLYCellModel alloc] init];
                cellModel.sectionModel = sectionModel;
                [TBXML iterateAttributesOfElement:element withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
                    [cellModel setValue:attributeValue forKey:attributeName];
                }];
                [cellArray addObject:cellModel];
            }];
            sectionModel.cellModelArray = cellArray;
            [sectionArray addObject:sectionModel];
        }];
        formModel.sectionModelArray = sectionArray;
        
        [rooms setObject:formModel forKey:formID];
    }];
    
    return rooms;

}

+ (NSMutableDictionary *)parseToForms{
    
    NSMutableDictionary *dict = [FLYFormParser parseToFormsWithFile:@"FLYForm.xml"];
    
    NSError *error;
    TBXML *tbxml = [TBXML newTBXMLWithXMLFile:@"FLYForm.xml" error:&error];
    if(error)
        NSLog(@"加载FLYForm.xml异常");
    [TBXML iterateElementsForQuery:@"include" fromElement:tbxml.rootXMLElement withBlock:^(TBXMLElement *element) {
        NSString *file = [TBXML valueOfAttributeNamed:@"file" forElement:element];
        [dict addEntriesFromDictionary:[FLYFormParser parseToFormsWithFile:file]];
    }];
    
    return dict;
    
}

@end
