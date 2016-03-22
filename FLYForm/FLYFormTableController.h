//
//  FLYFormTableController.h
//  Created by Tony Lee on 15/10/26.

#import <UIKit/UIKit.h>
#import "FLYFormModel.h"
#import "FLYTableViewCell.h"
#import "FLYFormForwardProtocol.h"

@interface FLYFormTableController : UIViewController<UITableViewDataSource,UITableViewDelegate,FLYTableViewCellDelegate>

@property(nonatomic,strong)FLYFormModel * flyFormModel;
@property (strong, nonatomic)UITableView *table;

//子类覆盖
-(void)flyFormModelSetting;

//子类覆盖，若需要对单元格进一步操作
- (void)flyTableViewCellSetting:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)aTable;

//跳转Controller之前的拦截
-(void)forwardControllerIntercepter:(FLYTableViewCell *)flyTableViewCell atIndexPath:(NSIndexPath *)indexPath forwardController: (id) aForwardController;

@end
