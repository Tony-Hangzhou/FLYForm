//
//  FLYSectionModel.m
//  Created by Tony Lee on 15/10/26.

#import "FLYSectionModel.h"

@implementation FLYSectionModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未知的FLYForm.xml属性：%@",key);
}

-(UIView *)headerView{
    if (_headerView) {
        return _headerView;
    }
    if (self.headerClass && self.headerClass.trim.length>0) {
        Class cls = NSClassFromString(self.headerClass);
        _headerView = [[cls alloc] init];
        return _headerView;
    }
    return Nil;
}

-(UIView *)footerView{
    if (_footerView) {
        return _footerView;
    }
    if (self.footerClass && self.footerClass.trim.length>0) {
        Class cls = NSClassFromString(self.footerClass);
        _footerView = [[cls alloc] init];
        return _footerView;
    }
    return Nil;
}
@end
