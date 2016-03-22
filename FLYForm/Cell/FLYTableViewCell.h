//
//  FLYTableViewCell.h
//  Created by Tony Lee on 15/10/26.

#import <UIKit/UIKit.h>
#import "FLYCellModel.h"


@protocol FLYTableViewCellDelegate <NSObject>

@optional
-(void)valueChangeForFLYCellModel:(FLYCellModel *)aCellModel;
-(void)valueChangeForFLYCellModel:(FLYCellModel *)aCellModel inComponent:(NSInteger)componet inRow:(NSInteger)rowIndex;

@end

@interface FLYTableViewCell : UITableViewCell<FLYTableViewCellDelegate>

@property(nonatomic,strong) FLYCellModel *cellModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellModel:(FLYCellModel *)aCellModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellModel:(FLYCellModel *)aCellModel andDelegate:(id<FLYTableViewCellDelegate>)aDelegate;

// 子类覆盖方法
- (void)setUp;

// 设置验证类,子类覆盖方法
- (void)setUpForValidator;

// 子类覆盖方法，选中当前Cell响应方法
- (void)didSelectWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller;

@property(nonatomic,assign) id<FLYTableViewCellDelegate> delegate;


@end
