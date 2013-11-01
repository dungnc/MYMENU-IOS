//
//  AFOptionText.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "AFSearchLocation.h"
#import "AFJSONRequestOperation.h"
#import "AFAppClient.h"
#import "LocationObject.h"
@implementation AFOptionText
- (id) initWithGetResultAttribute:(NSDictionary*)attribute items:(NSMutableArray*)items
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:[attribute valueForKey:@"id"]==[NSNull null]?(@""):([attribute valueForKey:@"id"]) forKey:@"id"];
    [item setObject:[attribute valueForKey:@"name"]==[NSNull null]?(@""):([attribute valueForKey:@"name"]) forKey:@"name"];
    [item setObject:[attribute valueForKey:@"address"]==[NSNull null]?(@""):([attribute valueForKey:@"address"]) forKey:@"address"];
    [item setObject:[attribute valueForKey:@"logo"]==[NSNull null]?(@""):([attribute valueForKey:@"logo"]) forKey:@"logo"];
    [item setObject:[attribute valueForKey:@"lat"]==[NSNull null]?(@""):([attribute valueForKey:@"lat"]) forKey:@"lat"];
    [item setObject:[attribute valueForKey:@"long"]==[NSNull null]?(@""):([attribute valueForKey:@"long"]) forKey:@"long"];
    [items addObject:item];
    return self;
}
+ (void) getTextWithBlock:(void(^)(NSString *result, NSArray *items, NSError *error))block pushParam:(NSDictionary *)params
                 pushPath:(NSString *)path;
{
    [[AFAppClient sharedClient]getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@:",responseObject);
        NSDictionary *jsonResult = responseObject;
       // NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //[self.delegate getListRestaurant:jsonResult];
        NSArray *itemsArray = (NSArray*)jsonResult;
        //NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[itemsArray count]];
        NSMutableArray *theLocations = [NSMutableArray new];
        for(NSDictionary *attribute in itemsArray)
        {
            [theLocations addObject:[LocationObject locationObjectFromDictionary:attribute]];
            //[[LocationObject locationObjectFromDictionary:attribute] printLocation];
            //(void)[[AFOptionText alloc] initWithGetResultAttribute:attribute items:items];
        }
        if(block)
        {
            block(@"ok", [NSArray arrayWithArray:theLocations], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(nil, [NSArray array], error);
        }
        
    }];
}
@end
