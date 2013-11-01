//
//  RestaurantDetailObject.m
//  myMenu
//
//  Created by HoaTruong on 10/28/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "RestaurantDetailObject.h"

@implementation RestaurantDetailObject

-(NSMutableArray *)jsonResult
{
    NSMutableArray *_jsonResult = [NSMutableArray new];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:91],@"id",
                          @"KFC",@"name",
                          @"123.123.1234",@"phone",
                         // @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                          @"84-Le Ngo Cat",@"address",
                          @"www.tuoitre.vn",@"web",
                          @"10am-11pm",@"timeOnOff",
                        //  @"33.418235",@"lat",
                        //  @"-94.10113699999999",@"long",
                          nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:92],@"id",
                           @"Muoi ot",@"name",
                           @"456.123.1234",@"phone",
                           // @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                           @"85-Le Ngo Cat",@"address",
                           @"www.24h.com.vn",@"web",
                           @"10am-11pm",@"timeOnOff",
                           nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:93],@"id",
                           @"Hoa Troc LoC",@"name",
                           @"789.123.1234",@"phone",
                           // @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                           @"86-Le Ngo Cat",@"address",
                           @"www.zing.vn",@"web",
                           @"10am-11pm",@"timeOnOff",
                           nil];
    [_jsonResult addObject:dict];
    [_jsonResult addObject:dict2];
    [_jsonResult addObject:dict3];
    return _jsonResult;
}
@end
