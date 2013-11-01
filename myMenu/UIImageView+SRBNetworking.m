#import "UIImageView+SRBNetworking.h"
#import <objc/runtime.h>
#import "SRBNetworkingClient.h"
#import "SRBNetworkingImageRequest.h"

static SRBNetworkingClient	*__defaultImageNetworkingClient = nil;
static SRBNetworkingClient	*__imageNetworkingClient = nil;

static BOOL	__imageNetworkingShowsActivityIndicator = YES;
static BOOL __shouldCacheImagesForNetworkingClient = YES;

#define kActivityIndicatorViewTag	42101421
#define kPendingRequestsKey			"pendingSRBNetworkingRequests"

@implementation UIImageView (SRBNetworking)

-(void) loadImageAsyncWithURL: (NSURL *) url placeholderImage: (UIImage *) placeholderImage
{
	[self loadImageAsyncWithURL: url placeholderImage: placeholderImage networkingClient: [self networkingClient]];
}

-(void) loadImageAsyncWithURL: (NSURL *) url placeholderImage: (UIImage *) placeholderImage networkingClient: (SRBNetworkingClient *) networkingClient
{
	if ( !url ) return;
	
	// cancel any requests currently in-flight for this image view
	[[self pendingRequests] enumerateObjectsUsingBlock:^(SRBNetworkingRequest *pendingRequest, NSUInteger idx, BOOL *stop) {
		[pendingRequest cancel];
	}];
	
	[[self activityIndicator] startAnimating];
	
	// configure our cache
	if ( __shouldCacheImagesForNetworkingClient )
	{
		if ( !networkingClient.cache ) networkingClient.cache = (id<SRBNetworkingCacheProtocol>)[NSCache new];
	}
	else 
	{
		if ( networkingClient.cache ) networkingClient.cache = nil;
	}
	
	SRBNetworkingImageRequest *request = [[SRBNetworkingImageRequest alloc] initWithBaseURL: url resourcePath: nil];
	request.shouldCacheResult = __shouldCacheImagesForNetworkingClient;
	request.requestCompletionQueue = dispatch_get_main_queue();
	[[self pendingRequests] addObject: request];
	
	[networkingClient sendAsyncronousRequest: request completionBlock:^(SRBNetworkingRequest *request) {
		[[self activityIndicator] removeFromSuperview];
		
		// verify this is the last pending request we've received for this UIImageView (since they could conceivably be returned out of order)
		if ( [[self pendingRequests] indexOfObject: request] == [[self pendingRequests] count] - 1 )
		{
			self.image = request.modelObject ? request.modelObject : placeholderImage;
		}
		[[self pendingRequests] removeObjectIdenticalTo: request];
	}];
}

+(void) setShowActivityIndicatorWhenLoadingImageWithURL: (BOOL) showActivityIndicator
{
	__imageNetworkingShowsActivityIndicator = showActivityIndicator;	
}

+(SRBNetworkingClient *) asyncNetworkingClient
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__defaultImageNetworkingClient = [SRBNetworkingClient new];
	});
	return __imageNetworkingClient ? __imageNetworkingClient : __defaultImageNetworkingClient;
}

+(void) setAsyncNetworkingClient: (SRBNetworkingClient *) networkingClient
{
	__imageNetworkingClient = networkingClient;
}

+(void) setShouldCacheImages: (BOOL) cacheImages
{
	__shouldCacheImagesForNetworkingClient = cacheImages;
}


// If the user does not specify, we'll use our own separate networking client for image requests.
-(SRBNetworkingClient *) networkingClient
{
	return [[self class] asyncNetworkingClient];
}

-(NSMutableArray *) pendingRequests
{
	NSMutableArray *pendingRequests = objc_getAssociatedObject( self, kPendingRequestsKey );
	if ( !pendingRequests )
	{
		pendingRequests = [NSMutableArray array];
		objc_setAssociatedObject( self, kPendingRequestsKey, pendingRequests, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
	}
	return pendingRequests;
}

-(UIActivityIndicatorView *) activityIndicator
{
	UIActivityIndicatorView *activityIndicator = nil;
	if ( __imageNetworkingShowsActivityIndicator )
	{
		activityIndicator = (UIActivityIndicatorView *)[self viewWithTag: kActivityIndicatorViewTag];
		if ( !activityIndicator )
		{
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
			activityIndicator.tag = kActivityIndicatorViewTag;
			activityIndicator.center = CGPointMake( floorf(self.bounds.size.width/2.), floorf(self.bounds.size.height/2.0) );
			[self addSubview: activityIndicator];
		}
	}
	return activityIndicator;
}

@end
