//
//  ViewController.m
//  FlyFormDemo
//
//  Created by Tony Lee on 16/3/21.
//  Copyright © 2016年 刚子. All rights reserved.
//

#import "ViewController.h"
#import "FLYForm.h"
#import "SaveSectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FLYForm DEMO";
}

-(void)loadDataSource{
    
    self.flyFormModel.bindData[@"price"] = @"7.5";
    self.flyFormModel.bindData[@"number"] = @"10";
    self.flyFormModel.bindData[@"unit"] = @"件";
    self.flyFormModel.bindData[@"name"] = @"李某某";
    self.flyFormModel.bindData[@"phone"] = @"18058159855";
    [self total];
    
    [self.table reloadData];
    
}


#pragma mark - 覆盖父类方法

-(void)flyFormModelSetting{
    self.flyFormModel = [FLYForm formModelWithID:@"修改订单"];
    
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[1];
    SaveSectionView * sectionView = [[SaveSectionView alloc] init];
    sectionView.delegate = self;
    sectionModel.footerView = sectionView;
    
    [self loadDataSource];

}

// 重定义Cell操作，比如为Cell增加特定的委托
- (void)flyTableViewCellSetting:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)aTable{
    
}

// 拦截Controller在跳转页面之前的操作
-(void)forwardControllerIntercepter:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath forwardController: (id) aForwardController{
    
}

#pragma mark - FlyFormCellDelegate
-(void)valueChangeForFLYCellModel:(FLYCellModel *)aCellModel{
    if ([aCellModel.key isEqualToString:@"price"] || [aCellModel.key isEqualToString:@"number"]) {
        [self total];
    }
}

#pragma mark - SaveSectionViewDelegate
-(void)btnAction:(UIButton *)sender{
    NSString *str = [self.flyFormModel doValidate];
    if (str) {
        NSLog(@"表单验证：%@",str);
    }
    NSLog(@"%@",self.flyFormModel.bindData);

}

#pragma - Private
-(void)total{
    float zongji = [self.flyFormModel.bindData[@"number"] intValue] * [self.flyFormModel.bindData[@"price"] doubleValue];
    self.flyFormModel.bindData[@"totalAmount"] = [NSString stringWithFormat:@"%.2f",zongji];
    [self.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
