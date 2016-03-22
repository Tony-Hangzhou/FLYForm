//
//  FLYTableViewCell.m
//  Created by Tony Lee on 15/10/26.

#import "FLYTableViewCell.h"
#import "FLYFormValidatorProtocol.h"

@implementation FLYTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellModel:(FLYCellModel *)aCellModel{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier andCellModel:aCellModel andDelegate:Nil];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellModel:(FLYCellModel *)aCellModel andDelegate:(id<FLYTableViewCellDelegate>)aDelegate{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _delegate = aDelegate;
        _cellModel = aCellModel;
        [self setUp];
        [self setUpForValidator];
    }
    return self;

}

- (void)setUp{
    
}

- (void)setUpForValidator{
    
    for (NSString *cls in self.cellModel.validateClassArray) {
        Class class = NSClassFromString(cls);
        if ([class conformsToProtocol:@protocol(FLYFormValidatorProtocol)]) {
            id<FLYFormValidatorProtocol> validate = [[class alloc] init];
            [validate setup:self.cellModel andField:self.detailTextLabel];
        }
    }

    
}


// 子类覆盖方法，选中当前Cell响应方法
- (void)didSelectWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller{
    
}


@end
