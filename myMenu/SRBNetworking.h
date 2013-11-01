#import <Foundation/Foundation.h>

#import "SRBNetworkingClient.h"
#import "SRBNetworkingRequest.h"

#if __has_feature(objc_arc_weak)
#define __WEAK __weak
#else
#define __WEAK __unsafe_unretained
#endif


#ifndef DLog
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif
