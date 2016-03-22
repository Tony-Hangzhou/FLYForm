//
//  HJCAjustNumButton.m
//  HJCAdjustButtonTest
//
//  Created by HJaycee on 15/6/4.
//  Copyright (c) 2015年 HJaycee. All rights reserved.
//

#import "HJCAjustNumButton.h"

@interface HJCAjustNumButton ()<UITextFieldDelegate>
{
    UIButton *_decreaseBtn;
    UIButton *_increaseBtn;
    UIView *_oneLine;
    UIView *_twoLine;
    NSTimer *_timer;
}

@end

@implementation HJCAjustNumButton

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self commonSetup];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    
    self.layer.borderColor = [lineColor CGColor];
    _oneLine.backgroundColor = lineColor;
    _twoLine.backgroundColor = lineColor;
}

- (void)setCurrentNum:(NSString *)currentNum{
    _textField.text = currentNum;
}

- (NSString *)currentNum{
    return _textField.text;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UIColor *lineColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    
    self.frame = CGRectMake(0, 0, 100, 25);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [lineColor CGColor];
    
    _oneLine = [[UIView alloc] init];
    _oneLine.backgroundColor = lineColor;
    [self addSubview:_oneLine];
    
    _twoLine = [[UIView alloc] init];
    _twoLine.backgroundColor = lineColor;
    [self addSubview:_twoLine];
    
    _decreaseBtn = [[UIButton alloc] init];
    [self setupButton:_decreaseBtn normalImage:@"decrease@2x" HighlightImage:@"decrease2@2x"];
    [self addSubview:_decreaseBtn];
    
    _increaseBtn = [[UIButton alloc] init];
    [self setupButton:_increaseBtn normalImage:@"increase@2x" HighlightImage:@"increase2@2x"];
    [self addSubview:_increaseBtn];
    
    _textField = [[UITextField alloc] init];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15];
    _textField.text = @"1";
    _textField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:_textField];

    [self addSubview:_textField];
    
    [self commonSetup];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0 || [textField.text isEqualToString:@"0"] || [textField.text intValue]<1) {
        textField.text = @"1";
    }
    self.callBack(_textField.text);
}
- (void)textDidChange{
    [self textFieldDidEndEditing:_textField];
}


- (void)commonSetup{
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    
    _oneLine.frame = CGRectMake(viewH, 0, 1, viewH);
    _decreaseBtn.frame = CGRectMake(0, 0, viewH, viewH);
    _twoLine.frame = CGRectMake(viewW - viewH, 0, 1, viewH);
    _increaseBtn.frame = CGRectMake(viewW - viewH, 0, viewH, viewH);
    _textField.frame = CGRectMake(viewH, 0, viewW - viewH * 2, viewH);
}

- (void)setupButton:(UIButton *)btn normalImage:(NSString *)norImage HighlightImage:(NSString *)highImage{
    [btn setImage:[self readImageFromBundle:norImage] forState:UIControlStateNormal];
    [btn setImage:[self readImageFromBundle:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(btnTouchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
}

- (void)btnTouchDown:(UIButton *)btn{
    [_textField resignFirstResponder];
    
    if (btn == _increaseBtn) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(increase) userInfo:nil repeats:YES];
    } else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(decrease) userInfo:nil repeats:YES];
    }
    [_timer fire];
}

- (void)btnTouchUp:(UIButton *)btn{
    [self cleanTimer];
}

- (void)increase{
    if (_textField.text.length == 0) {
        _textField.text = @"1";
    }
    int newNum = [_textField.text intValue] + 1;
    _textField.text = [NSString stringWithFormat:@"%i", newNum];
    self.callBack(_textField.text);
}

- (void)decrease{
    if (_textField.text.length == 0) {
        _textField.text = @"1";
    }
    int newNum = [_textField.text intValue] -1;
    if (newNum > 0) {
        _textField.text = [NSString stringWithFormat:@"%i", newNum];
        self.callBack(_textField.text);
    } else {
        NSLog(@"num can not less than 1");
    }
}

- (UIImage *)readImageFromBundle:(NSString *)imageName{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"HJCAdjustNumButton.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *(^getBundleImage)(NSString *) = ^(NSString *n) {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:n ofType:@"png"]];
    };
    UIImage *myImg = getBundleImage(imageName);
    return myImg;
}

- (void)dealloc{
    [self cleanTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)cleanTimer{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
