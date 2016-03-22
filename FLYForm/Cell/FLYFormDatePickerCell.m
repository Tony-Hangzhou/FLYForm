//
//  FLYFormDatePickerCell.m
//  Created by Tony Lee on 15/10/26.

#import "FLYFormDatePickerCell.h"

@interface FLYFormDatePickerCell(){
    bool open;
}
@end

@implementation FLYFormDatePickerCell

- (void)setUp
{
    [super setUp];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.detailTextLabel.textColor = [UIColor colorWithHex:0x333333];
    
    open=NO;
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    self.datePicker.locale = locale;
    [self.datePicker addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

-(UIToolbar *)toolbar{
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    pickerDateToolbar.barStyle = UIBarStyleDefault;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCanelClick:)];
    [barItems addObject:cancelBtn];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarDoneClick:)];
    [barItems addObject:doneBtn];
    [pickerDateToolbar setItems:barItems animated:YES];
    return pickerDateToolbar;
}

-(void)toolBarCanelClick:(UIButton *)btn{
    open = NO;
    [self resignFirstResponder];
}

-(void)toolBarDoneClick:(UIButton *)btn{
    
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.detailTextLabel.text = destDateString;
    self.cellModel.fieldValue = self.detailTextLabel.text;
    [self setNeedsLayout];
    open = NO;
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputView
{
    CGFloat toolbarHight = 35.;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.datePicker.frame.origin.x, self.datePicker.frame.origin.y, self.datePicker.frame.size.width, self.datePicker.frame.size.height + toolbarHight)];
    self.datePicker.frame = CGRectMake(self.datePicker.frame.origin.x, toolbarHight, [UIScreen mainScreen].bounds.size.width, self.datePicker.frame.size.height);
    [view addSubview:self.datePicker];
    [view addSubview:self.toolbar];
    
    return view;
}

- (void)valueChanged
{
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    self.detailTextLabel.text = destDateString;
    self.cellModel.fieldValue = self.detailTextLabel.text;
    [self setNeedsLayout];
    
}


- (void)didSelectWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller{
    if (!open)
    {
        [self becomeFirstResponder];
        open = YES;
    }
    else
    {
        [self resignFirstResponder];
        open = NO;
    }
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
}


@end
