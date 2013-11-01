//
//  AFLogin.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFLogin;

@protocol AFLoginDelegate
- (void) returnInfoAfterLogin:(NSDictionary*) JSON;

@end
@interface  AFLogin: NSObject
- (void) login:(NSDictionary*)params and:(NSString*)path;
@property (nonatomic, assign) id <AFLoginDelegate> delegate;
@property (nonatomic, retain) NSDictionary * jsonResult;

@end
