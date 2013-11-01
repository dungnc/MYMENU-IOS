#import <UIKit/UIKit.h>

@class SRBNetworkingClient;

@interface UIImageView (SRBNetworking)

// load our images async
-(void) loadImageAsyncWithURL: (NSURL *) url placeholderImage: (UIImage *) placeholderImage;

// optional configuration 
+(void) setShowActivityIndicatorWhenLoadingImageWithURL: (BOOL) showActivityIndicator;			// optional; default is YES
+(SRBNetworkingClient *) asyncNetworkingClient;													// optional; tweak defaults of existing networking client
+(void) setAsyncNetworkingClient: (SRBNetworkingClient *) networkingClient;						// optional; replace default networking client; useful if you want all requests to go to same opQ (throttle image flooding)
+(void) setShouldCacheImages: (BOOL) cacheImages;												// optional; default is YES; uses NSCache

@end
