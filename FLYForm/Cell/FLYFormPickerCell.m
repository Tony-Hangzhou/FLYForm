//
//  FLYFormPickerCell.m
//  Created by Tony Lee on 15/10/26.
//  数据源支持FLYForm.OptionSingleData.plist或者optionsDataDynamic数组里json对象格式如：{@"text":@"",@"code":@""}

#import "FLYFormPickerCell.h"
#import "FLYFormValidatorProtocol.h"
#import "FLYForm.h"

@interface FLYFormPickerCell(){
    bool open;
    NSArray *data;
    NSInteger currentComponent;
    NSInteger currentRow;
}


@end

@implementation FLYFormPickerCell

- (void)setUp
{
    [super setUp];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.detailTextLabel.textColor = [UIColor colorWithHex:0x333333];
    open = FALSE;
    
    if (!self.cellModel.fieldValue || self.cellModel.fieldValue.trim.length==0) {
        self.detailTextLabel.textColor = [UIColor colorWithHex:0xcccccc];
        self.detailTextLabel.text = self.cellModel.placeholder;
    }else{
        self.detailTextLabel.textColor = [UIColor colorWithHex:0x333333];
        self.detailTextLabel.text = self.cellModel.fieldValue;
    }

    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    if (self.cellModel.optionsDataDynamic) {
        data = self.cellModel.optionsDataDynamic;
    }else if (self.cellModel.optionsData && self.cellModel.optionsData.trim.length>0) {
        data = [FLYForm optionSingleDataWithKey:self.cellModel.optionsData.trim];
    }
    currentComponent = 0;
    currentRow = 0;
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
    open = NO;
    if ([data count]>0) {
        NSDictionary *dict = data[currentRow];
        self.detailTextLabel.textColor = [UIColor colorWithHex:0x333333];
        self.detailTextLabel.text = dict[@"text"];
        self.cellModel.fieldValue = dict[@"text"];
        self.cellModel.fieldValueTexts = @[dict[@"text"]];
        self.cellModel.fieldValueCodes = @[dict[@"code"]?dict[@"code"]:@""];
        
        if ([self.delegate respondsToSelector:@selector(valueChangeForFLYCellModel:inComponent:inRow:)]) {
            [self.delegate valueChangeForFLYCellModel:self.cellModel inComponent:currentComponent inRow:currentRow];
        }
    }
    [self resignFirstResponder];
}


- (void)dealloc
{
    _pickerView.dataSource = nil;
    _pickerView.delegate = nil;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputView
{
    CGFloat toolbarHight = 35.;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.pickerView.frame.origin.x, self.pickerView.frame.origin.y, self.pickerView.frame.size.width, self.pickerView.frame.size.height + toolbarHight)];
    self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x, toolbarHight, [UIScreen mainScreen].bounds.size.width, self.pickerView.frame.size.height);
    [view addSubview:self.pickerView];
    [view addSubview:self.toolbar];
    return view;
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


- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(__unused UIPickerView *)pickerView numberOfRowsInComponent:(__unused NSInteger)component
{
    return [data count];
}

- (NSString *)pickerView:(__unused UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(__unused NSInteger)component
{
    return data[row][@"text"];
}

- (void)pickerView:(__unused UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(__unused NSInteger)component
{
    if (data.count==0) {
        return;
    }
    currentComponent = component;
    currentRow = row;
    [self setNeedsLayout];
}
@end
