//
//  LocationObject.h
//  myMenu
//
//  Created by Judge Man on 10/25/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "SRBAutomappingModelObject.h"

@interface LocationObject : SRBAutomappingModelObject <MKAnnotation>
@property (nonatomic, assign) NSInteger locationID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *locationURL;
@property (nonatomic, strong) NSString *logoURL;
@property (nonatomic, strong) UIImage *logo;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger ratingCount;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageURLs;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+ (LocationObject *)locationObjectFromDictionary:(NSDictionary *)dictionary;
+ (LocationObject *)dummyLocation;
- (void)printLocation;
+ (NSArray *)dummyLocations;
@end
