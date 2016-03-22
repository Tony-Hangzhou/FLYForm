//
//  FLYFormGeneralCell.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormGeneralCell.h"

@implementation FLYFormGeneralCell


- (void)setUp
{
    self.textLabel.text = [self.cellModel.title defaultNilIfNULL];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor colorWithHex:0x999999];
    self.detailTextLabel.text = [self.cellModel.fieldValue  defaultNilIfNULL];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    self.detailTextLabel.textColor = [UIColor colorWithHex:0x666666];
    
    if (self.cellModel.forwardController && self.cellModel.forwardController.trim.length>0) {
        self.detailTextLabel.text = @"";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
