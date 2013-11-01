//
//  HomeMenu.m
//  myMenu
//
//  Created by Judge Man on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "HomeMenu.h"

@implementation HomeMenu
+(NSMutableArray*) returnListMenu
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group1",@"imagePath",
                          @"MyPoints",@"name",  nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group2",@"imagePath",
                          @"MyNotifications",@"name",  nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group3",@"imagePath",
                          @"MySettings",@"name",  nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group4",@"imagePath",
                          @"MySearch",@"name",  nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group5",@"imagePath",
                          @"MyFriends",@"name",  nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group6",@"imagePath",
                          @"MyWallet",@"name",  nil];
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group7",@"imagePath",
                          @"MyFavorites",@"name",  nil];
    NSDictionary *dict8 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group8",@"imagePath",
                          @"MyCalories",@"name",  nil];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ic_group8.png",@"imagePath",
                          @"MyStats",@"name",  nil];
    NSMutableArray *homeMenu = [NSMutableArray new];
    [homeMenu addObject:dict];
    [homeMenu addObject:dict2];
    [homeMenu addObject:dict3];
    [homeMenu addObject:dict4];
    [homeMenu addObject:dict5];
    [homeMenu addObject:dict6];
    [homeMenu addObject:dict7];
    [homeMenu addObject:dict8];
    [homeMenu addObject:dict9];
    return homeMenu;


}
@end
