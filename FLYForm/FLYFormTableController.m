//
//  FLYFormTableController.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormTableController.h"
#import "FLYFormModel.h"
#import "FLYForm.h"

#import "FLYTableViewCell.h"
#import "FLYCellModel.h"
#import "FLYSectionModel.h"
#import "FLYFormForwardProtocol.h"

@implementation FLYFormTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    _table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _table.sectionFooterHeight=0;
    _table.sectionHeaderHeight=0;
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    
    [self flyFormModelSetting];
}

-(void)flyFormModelSetting{
    
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[section];
    return sectionModel.headerView.frame.size.height;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[section];
    return  sectionModel.headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%lu",(unsigned long)[self.flyFormModel.sectionModelArray count]);
    return [self.flyFormModel.sectionModelArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[section];
    return [sectionModel.cellModelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[indexPath.section];
    FLYCellModel *cellModel = sectionModel.cellModelArray[indexPath.row];
    if (![cellModel.cellClass defaultNilIfNULL]) {
        NSLog(@"%@缺少CellClass",cellModel.title);
        return Nil;
    }
    Class cellClass = NSClassFromString(cellModel.cellClass);
    FLYTableViewCell *cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier andCellModel:cellModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [self flyTableViewCellSetting:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

//子类覆盖，若需要对单元格进一步操作
- (void)flyTableViewCellSetting:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)aTable{
    
}

-(void)forwardControllerIntercepter:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath forwardController: (id<FLYFormForwardProtocol>) aForwardController{
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[section];
    return  sectionModel.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    FLYSectionModel *sectionModel = self.flyFormModel.sectionModelArray[section];
    return sectionModel.footerView?sectionModel.footerView.frame.size.height:0;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLYTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didSelectWithTableView:indexPath:controller:)])
    {
        [cell didSelectWithTableView:tableView indexPath:indexPath controller:self];
    }
    if (cell.cellModel.forwardController && cell.cellModel.forwardController.trim.length>0) {
        
        Class cls = NSClassFromString(cell.cellModel.forwardController.trim);
        if ([cls conformsToProtocol:@protocol(FLYFormForwardProtocol)]) {
            id<FLYFormForwardProtocol> controller = [[cls alloc] initWithFLYFormModel:self.flyFormModel];
            [self forwardControllerIntercepter:cell atIndexPath:indexPath forwardController:controller];
           
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            UIViewController *controller = [[cls alloc] init];
            [self forwardControllerIntercepter:cell atIndexPath:indexPath forwardController:controller];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


#pragma mark - FLYTableViewCellDelegate
-(void)valueChangeForFLYTableViewCell:(NSString *)aValue{
    
}

@end
