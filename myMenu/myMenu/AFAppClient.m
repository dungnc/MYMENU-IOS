//
//  AFAppClient.m
//  myMenu
//
//  Created by Judge Man on 10/26/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "AFAppClient.h"
#import "AFJSONRequestOperation.h"
@implementation AFAppClient
+ (AFAppClient*) sharedClient
{
    static AFAppClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppClient alloc] initWithBaseURL:[NSURL URLWithString:kAPILink]];
    });
    
    return _sharedClient;
}
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    self.parameterEncoding = AFJSONParameterEncoding;
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}
@end
