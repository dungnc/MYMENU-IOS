//
//  Data_Restaurant.m
//  myMenu
//
//  Created by Judge Man on 10/25/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "Data_Restaurant.h"

@implementation Data_Restaurant
-(NSMutableArray *)jsonResult
{
    NSMutableArray *_jsonResult = [NSMutableArray new];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:91],@"id",
                           @"KFC",@"name",
                           @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                           @"84-Le Ngo Cat",@"address",
                           @"33.418235",@"lat",
                           @"-94.10113699999999",@"long",  nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:92],@"id",
                           @"Muoi ot",@"name",
                           @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                           @"84-Le Ngo Cat",@"address",
                           @"33.418235",@"lat",
                           @"-94.10113699999999",@"long",  nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:93],@"id",
                           @"Hoa Troc LoC",@"name",
                           @"/uploads/location/logo/116/IMG_3594.JPG",@"logo",
                           @"84-Le Ngo Cat",@"address",
                           @"33.418235",@"lat",
                           @"-94.10113699999999",@"long",  nil];
    [_jsonResult addObject:dict];
    [_jsonResult addObject:dict2];
    [_jsonResult addObject:dict3];
    return _jsonResult;
}
@end
