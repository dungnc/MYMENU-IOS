//
//  NSString+EmailValidation.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "NSString+EmailValidation.h"

@implementation NSString (EmailValidation)

-(BOOL) isValidEmailAddress
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx] evaluateWithObject: self];
}

@end
