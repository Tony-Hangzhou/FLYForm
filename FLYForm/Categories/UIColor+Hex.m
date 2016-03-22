//
//  UIColor+Hex.m
//  Created by Tony Lee on 15/4/22.
#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor
{
	float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
	float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
	float blue = ((float)(hexColor & 0xFF))/255.0;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}


+ (id)colorWithHexStr:(NSString *)hex
{
	NSAssert(7 == hex.length, @"Hex color format error!");
	
	unsigned color = 0;
	NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
	[hexValueScanner scanHexInt:&color];
	
	int blue = color & 0xFF;
	int green = (color >> 8) & 0xFF;
	int red = (color >> 16) & 0xFF;
	
	return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

@end