//
//  LocationDataController.m
//  myMenu
//
//  Created by Judge Man on 10/27/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "LocationDataController.h"

@implementation LocationDataController
-(Location*) getCurrentLocation
{
    Location *myLocation = [[Location alloc] init];
    myLocation.latitude = 30.2669;
    myLocation.longitude = -97.7428;
    return myLocation;
}
-(NSArray*) getMinAndMaxLatitueAndLogitude:(NSArray*) locationObjs
{
    NSMutableArray *locations = [[NSMutableArray alloc]init];
    Location *minLocation = [[Location alloc] init];
    float minlatitue = [[locationObjs objectAtIndex:0] latitude];
    float minlongitue = [[locationObjs objectAtIndex:0] longitude];
    Location *maxLocation = [[Location alloc] init];
    float maxlatitue = [[locationObjs objectAtIndex:0] latitude];
    float maxlongitue = [[locationObjs objectAtIndex:0] longitude];
    for(LocationObject *obj in locationObjs)
    {
        if(minlatitue>[obj latitude])
            minlatitue= [obj latitude];
        
        if(minlongitue>[obj longitude])
            minlongitue= [obj longitude];
        
        if(maxlatitue<[obj latitude])
            maxlatitue= [obj latitude];
        
        if(maxlongitue<[obj longitude])
            maxlongitue= [obj longitude];
    }
    minLocation.latitude = minlatitue;
    minLocation.longitude = minlongitue;
    maxLocation.latitude = maxlatitue;
    maxLocation.longitude = maxlongitue;
    [locations addObject:minLocation];
    [locations addObject:maxLocation];
    return [NSArray arrayWithArray:locations];
}
@end
