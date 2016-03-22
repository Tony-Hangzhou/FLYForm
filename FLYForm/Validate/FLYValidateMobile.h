//
//  FLYValidateMobile.h
//  Created by Tony Lee on 15/10/26.



#import "FLYFormValidatorProtocol.h"

@interface FLYValidateMobile : NSObject<FLYFormValidatorProtocol>

-(BOOL)doValidateWithMobile:(NSString *)mobile;

@end