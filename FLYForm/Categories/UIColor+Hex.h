//
//  UIColor+Hex.h

//  Created by Tony Lee on 15/4/22.

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (id)colorWithHexStr:(NSString *)hex;

@end
