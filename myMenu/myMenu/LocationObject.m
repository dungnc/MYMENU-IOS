//
//  LocationObject.m
//  myMenu
//
//  Created by Judge Man on 10/25/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//

#import "LocationObject.h"
#import "MyMenuAppController.h"

@implementation LocationObject

- (id)init {
    if (self = [super init]) {
        [self addMappingWithDestinationKey: @"address" sourceKeyPath:@"address"];
        [self addMappingWithDestinationKey: @"city" sourceKeyPath:@"city"];
        [self addMappingWithDestinationKey: @"country" sourceKeyPath:@"country"];
        [self addMappingWithDestinationKey: @"phone" sourceKeyPath:@"phone"];
        [self addMappingWithDestinationKey: @"locationID" sourceKeyPath: @"id"];
        [self addMappingWithDestinationKey: @"locationURL" sourceKeyPath: @"url"];
        [self addMappingWithDestinationKey: @"name" sourceKeyPath: @"name"];
        [self addMappingWithDestinationKey: @"logoURL" sourceKeyPath: @"logo"];
        [self addMappingWithDestinationKey: @"latitude" sourceKeyPath: @"lat"];
        [self addMappingWithDestinationKey: @"longitude" sourceKeyPath: @"long"];
        [self addMappingWithDestinationKey: @"rating" sourceKeyPath: @"rating"];
        [self addMappingWithDestinationKey: @"ratingCount" sourceKeyPath:@"ratings_count"];
        [self addMappingWithDestinationKey: @"state" sourceKeyPath: @"state"];
        [self addMappingWithDestinationKey: @"imageURLs" sourceKeyPath: @"images" formattingBlock: ^id(id data) {
            if (![data isKindOfClass: [NSArray class]]) {
                return nil;
            }
            NSArray *imagesArray = (NSArray *)data;
            NSMutableArray *theImages = [NSMutableArray new];
            for (NSDictionary *theImageDict in imagesArray) {
                NSString *theImageURL = [theImageDict objectForKey:@"image"];
                if (theImageURL && (NSNull *)theImageURL != [NSNull null]) {
                    [theImages addObject:theImageURL];
                }
            }
            return [NSArray arrayWithArray:theImages];
        }];

    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.locationID forKey:@"locationID"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.zip forKey:@"zip"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.locationURL forKey:@"locationURL"];
    [encoder encodeObject:self.logoURL forKey:@"logoURL"];
    [encoder encodeObject:self.logo forKey:@"logo"];
    [encoder encodeFloat:self.latitude forKey:@"latitude"];
    [encoder encodeFloat:self.longitude forKey:@"longitude"];
    [encoder encodeFloat:self.distance forKey:@"distance"];
    [encoder encodeInteger:self.rating forKey:@"rating"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeObject:self.imageURLs forKey:@"imageURLs"];
}
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.locationID = [decoder decodeIntegerForKey:@"locationID"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.zip = [decoder decodeObjectForKey:@"zip"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.locationURL = [decoder decodeObjectForKey:@"locationURL"];
        self.logoURL = [decoder decodeObjectForKey:@"logoURL"];
        self.logo = [decoder decodeObjectForKey:@"logo"];
        self.latitude = [decoder decodeFloatForKey:@"latitude"];
        self.longitude = [decoder decodeFloatForKey:@"longitude"];
        self.distance = [decoder decodeFloatForKey:@"distance"];
        self.ratingCount = [decoder decodeIntegerForKey:@"ratingCount"];
        self.rating = [decoder decodeIntegerForKey:@"rating"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.imageURLs = [decoder decodeObjectForKey:@"imageURLs"];
    }
    return self;
}

+ (LocationObject *)locationObjectFromDictionary:(NSDictionary *)dictionary {
    LocationObject *location = [self new];
    [location updateFromDictionary:dictionary];
    if (location.latitude != 0. && location.longitude != 0.) {
        CLLocationCoordinate2D locationDegrees = CLLocationCoordinate2DMake(location.latitude, location.longitude);
        location.coordinate = locationDegrees;
        location.distance = [[MyMenuAppController sharedController] locationDistanceInMilesFromCLLocation2D:locationDegrees];
    }
    return location;
}


#pragma mark MapView Methods
- (NSString*)description {
    return self.address;
}
- (NSString*)title {
    return self.name;
}
- (NSString*)subtitle {
    return self.address;
}
- (MKCoordinateRegion) locationObjectCoordinateRegion {
    CLLocationCoordinate2D coord = {.latitude =  self.latitude, .longitude =  self.longitude};
    return MKCoordinateRegionMakeWithDistance(coord, 5000, 5000);
}
- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{self.address : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}
- (void)printLocation {
    NSLog(@"id: %i", self.locationID);
    NSLog(@"name: %@", self.name);
    NSLog(@"address: %@", self.address);
    NSLog(@"city: %@", self.city);
    NSLog(@"state: %@", self.state);
    NSLog(@"zip: %@", self.zip);
    NSLog(@"country: %@", self.country);
    NSLog(@"phone: %@", self.phone);
    NSLog(@"ratingCount: %i", self.ratingCount);
    NSLog(@"latitude: %f", self.latitude);
    NSLog(@"longitude: %f", self.longitude);
    NSLog(@"rating: %i", self.rating);
    NSLog(@"locationURL: %@", self.locationURL);
    NSLog(@"Distance: %f", self.distance);
}
#pragma mark Dummy Methods
+ (LocationObject *)dummyLocation {
    LocationObject *location = [self new];
    location.locationID = 21;
    location.name = @"Black Sheep Lodge";
    location.address = @"2108 S Lamar Blvd";
    location.city = @"Austin";
    location.state = @"TX";
    location.zip = @"78704";
    location.phone = @"(512)555-5555";
    location.latitude = 30.248230;
    location.longitude = -97.771349;
    location.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"blackSheepLodge.png"], [UIImage imageNamed:@"blackSheepLodge2.png"], [UIImage imageNamed:@"blackSheepLodge3.png"], [UIImage imageNamed:@"blackSheepLodge4.png"], nil];
    return location;
}
+ (NSArray *)dummyLocations {
    LocationObject *location1 = [self new];
    location1.locationID = 10;
    location1.name = @"Chili's";
    location1.address = @"4236 S Lamar Blvd";
    location1.city = @"Austin";
    location1.state = @"TX";
    location1.zip = @"78704";
    location1.phone = @"(512)555-5555";
    location1.latitude = 30.2362726;
    location1.longitude = -97.7928064;
    location1.rating = 65;
    location1.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Trudys1.png"], [UIImage imageNamed:@"Trudys2.png"], [UIImage imageNamed:@"Trudys3.png"], [UIImage imageNamed:@"Trudys4.png"], nil];
    
    LocationObject *location2 = [self new];
    location2.locationID = 11;
    location2.name = @"Trudy's";
    location2.address = @"8820 Burnet Rd.";
    location2.city = @"Austin";
    location2.state = @"TX";
    location2.zip = @"78758";
    location2.phone = @"(512)555-5555";
    location2.latitude = 30.372116;
    location2.longitude = -97.726672;
    location2.rating = 50;
    location2.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Trudys1.png"], [UIImage imageNamed:@"Trudys2.png"], [UIImage imageNamed:@"Trudys3.png"], [UIImage imageNamed:@"Trudys4.png"], nil];
    
    LocationObject *location3 = [self new];
    location3.locationID = 12;
    location3.name = @"Cheesecake Factory";
    location3.address = @"10000 Research Blvd";
    location3.city = @"Austin";
    location3.state = @"TX";
    location3.zip = @"78759";
    location3.phone = @"(512)555-5555";
    location3.latitude = 30.3918412;
    location3.longitude = -97.7486068;
    location3.rating = 90;
    location3.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Trudys1.png"], [UIImage imageNamed:@"Trudys2.png"], [UIImage imageNamed:@"Trudys3.png"], [UIImage imageNamed:@"Trudys4.png"], nil];
    
    LocationObject *location4 = [self new];
    location4.locationID = 13;
    location4.name = @"The Salt Lick";
    location4.address = @"18300 Farm to Market 1826";
    location4.city = @"Driftwood";
    location4.state = @"TX";
    location4.zip = @"78619";
    location4.phone = @"(512)555-5555";
    location4.latitude = 30.1313324;
    location4.longitude = -98.01355;
    location4.rating = 85;
    location4.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Trudys1.png"], [UIImage imageNamed:@"Trudys2.png"], [UIImage imageNamed:@"Trudys3.png"], [UIImage imageNamed:@"Trudys4.png"], nil];
    
    LocationObject *location5 = [self new];
    location5.locationID = 14;
    location5.name = @"Max's Wine Dive";
    location5.address = @"207 San Jacinto Blvd";
    location5.city = @"Austin";
    location5.state = @"TX";
    location5.zip = @"78701";
    location5.phone = @"(512)555-5555";
    location5.latitude = 30.351980;
    location5.longitude = -97.701833;
    location5.rating = 75;
    location5.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Trudys1.png"], [UIImage imageNamed:@"Trudys2.png"], [UIImage imageNamed:@"Trudys3.png"], [UIImage imageNamed:@"Trudys4.png"], nil];
    
    return [NSArray arrayWithObjects:location1, location2, location3, location4, location5, nil];
}
@end
