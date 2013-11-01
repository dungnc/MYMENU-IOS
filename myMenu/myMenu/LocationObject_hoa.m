//
//  LocationObject.m
//  myMenu
//
//  Created by HoaTruong on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "LocationObject_hoa.h"

@implementation LocationObject_hoa
- (NSArray *)arrayImage{
     self.images = [NSArray arrayWithObjects: [UIImage imageNamed:@"index1.jpg"],[UIImage imageNamed:@"index2.jpg"], [UIImage imageNamed:@"index3.jpg"],[UIImage imageNamed:@"index4.jpg"], nil];
    return self.images;
}
- (NSString *)contentTitle:(NSInteger) index
{
    NSArray *content = [NSArray arrayWithObjects:@"Make Dining Out Simple",
                        @"Feast Your Eyes On This",
                        @"Save Your Favorites",@"Recelve Amazing Recommendations",nil];
    return [content objectAtIndex:index];
}
- (NSString *)contentNote:(NSInteger) index
{
    NSArray *content = [NSArray arrayWithObjects:@"",@"",@" (and Your 'Next Times')",@"",nil];
    return [content objectAtIndex:index];
}
- (NSString *)contentDescription:(NSInteger) index
{
    NSArray *content = [NSArray arrayWithObjects:@"Where to eat? What to eat? What's good here? MyMenu makes your dining out decisions simple",
                        @"You are finally able to see every mouth watering appetizer, dinner, or desert before you order",
                        @"Easily keep track of your davorite menu items. When there is a special, you'll be the first to know",
                        @"Mymenu learns your eating likes, helping you discover deliciuos items or new pairings",nil];
    return [content objectAtIndex:index];

}
@end
