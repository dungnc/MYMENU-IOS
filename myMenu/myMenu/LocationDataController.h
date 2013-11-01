//
//  LocationDataController.h
//  myMenu
//
//  Created by Judge Man on 10/27/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "LocationObject.h"
@interface LocationDataController : NSObject
-(Location*) getCurrentLocation;
-(NSArray*) getMinAndMaxLatitueAndLogitude:(NSArray*) locationObjs;
@end
