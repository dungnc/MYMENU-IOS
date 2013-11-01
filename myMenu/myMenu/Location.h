//
//  Location.h
//  myMenu
//
//  Created by Judge Man on 10/27/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) NSString *name;

@property (nonatomic) float latitude;

@property (nonatomic) float longitude;
@end
