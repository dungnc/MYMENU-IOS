//
//  AFAppClient.h
//  myMenu
//
//  Created by Judge Man on 10/26/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFAppClient : AFHTTPClient
+ (AFAppClient *)sharedClient;
@end
