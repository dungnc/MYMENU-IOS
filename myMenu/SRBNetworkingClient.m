#import "SRBNetworking.h"

@implementation SRBNetworkingClient

-(id) init
{
	if ( (self = [super init]) )
	{
		_operationQueue = [NSOperationQueue new];
	}
	return self;
}

-(void) sendAsyncronousRequest: (SRBNetworkingRequest *) request completionBlock: (SRBNetworkingRequestCompletionBlock) completionBlock
{
	request.requestCompletionBlock = completionBlock;
	if ( !request.requestCompletionQueue ) 
		request.requestCompletionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	__weak SRBNetworkingRequest *weakRequest = request;
    __weak SRBNetworkingClient *weakSelf = self;
	
	// process the response via the NSOperation -completionBlock
	request.completionBlock = ^{
		if ( !weakRequest.isCancelled ) 
		{
			[weakSelf requestDidComplete: weakRequest];
		}
	};
	
	// cache check 
	BOOL satisfiedWithCache = NO;
	if ( request.shouldCacheResult )
	{
		id resultsData = [self cachedResultsDataForRequest: request];
		if ( resultsData )
		{
#ifdef DEBUG_CACHE
            DLog(@"FULFILLED WITH CACHE: %@", request.urlRequest.URL.absoluteString);
#endif
			request.resultsData = resultsData;
			request.resultsError = nil;
			request.shouldCacheResult = NO;			// since we satisfied from cache, disable the saving to cache here.
			request.wasSatisfiedViaCache = YES;
			satisfiedWithCache = YES;
			
			[request requestDidComplete];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // we won't be saving the result to the cachse (which could be expensive), so just use the current queue
                [self requestDidComplete: request];
            });
		}
	}
	
	if ( !satisfiedWithCache )
	{
#ifdef DEBUG_CACHE
        DLog(@"NOT FULFILLED WITH CACHE, MAKING REQUEST: %@", request.urlRequest.URL.absoluteString);
#endif
		// async since the caller might want to continue configuring the request on the current runloop cycle before it goes in-flight
		dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			[self.operationQueue addOperation: request];
		});
	}
}

#pragma mark- Overrides 

-(void) cacheResultsData: (NSData *)data forRequest: (SRBNetworkingRequest *)request
{
    [self.cache setObject: data forKey: [request.urlRequest.URL absoluteString]];
}


-(id) cachedResultsDataForRequest: (SRBNetworkingRequest *)request
{
    return [self.cache objectForKey: [request.urlRequest.URL absoluteString]];
}

-(void) requestDidComplete:(SRBNetworkingRequest *)request
{
    // if we should cache, save off the result
	if ( request.shouldCacheResult && request.resultsData && [request.urlRequest.URL absoluteString] )
	{
#ifdef DEBUG_CACHE
        DLog(@"CACHING RESPONSE FOR REQUEST: %@", request.urlRequest.URL.absoluteString);
#endif
		[self cacheResultsData: request.resultsData forRequest: request];
	}
	
	if ( request.requestCompletionBlock && !request.isCancelled ) 
	{
		dispatch_async(request.requestCompletionQueue, ^{
			// fire our completion blocks			
			request.requestCompletionBlock( request );
		});
	}
}

@end

