#import <Foundation/Foundation.h>
#import "SRBNetworkingRequest.h"
#import "SRBNetworkingCacheProtocol.h"

@interface SRBNetworkingClient : NSObject

@property (nonatomic, readonly)		NSOperationQueue				*operationQueue;		// useful for tweaking settings in the opQ
@property (nonatomic, strong)		id<SRBNetworkingCacheProtocol>	cache;					// optional; requests with shouldCacheResult will use this supplied cache (NSCache 'compatible')

-(void) sendAsyncronousRequest: (SRBNetworkingRequest *) request completionBlock: (SRBNetworkingRequestCompletionBlock) completionBlock;

// overrides
-(void) cacheResultsData: (NSData *)data forRequest: (SRBNetworkingRequest *)request;       // option; override for custom caching; do not call super
-(id) cachedResultsDataForRequest: (SRBNetworkingRequest *)request;                         // option; override for custom caching; do not call super
-(void) requestDidComplete: (SRBNetworkingRequest *) request;								// optional; always call super if overriding; useful for subclasses that need to cull application level error information or common results from the request

@end

