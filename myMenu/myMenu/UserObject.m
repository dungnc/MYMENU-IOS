//
//  UserObject.m
//  myMenu
//
//  Created by HoaTruong on 10/30/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject
-(NSDictionary *) userAccount{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"abc",@"firstName",
                          @"abc",@"lastName",
                          @"abc@vn.vn",@"emailAddress",
                          @"xyz",@"userName",
                          @"123",@"zipCode",
                          @"www.tuoitre.vn",@"passsword",nil];
    return dict;
}
@end
