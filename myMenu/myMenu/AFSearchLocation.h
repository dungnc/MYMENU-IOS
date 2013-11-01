//
//  AFOptionText.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFOptionText : NSObject
+ (void) getTextWithBlock:(void(^)(NSString *result, NSArray *items, NSError *error))block pushParam:(NSDictionary *)params
                 pushPath:(NSString *)path;
- (id) initWithGetResultAttribute:(NSDictionary*)attribute items:(NSMutableArray*)items;
@end
