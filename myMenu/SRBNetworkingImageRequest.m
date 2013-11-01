#import "SRBNetworkingImageRequest.h"

static BOOL __imageRequestShouldCacheImages = YES;

@implementation SRBNetworkingImageRequest

-(id) formattedResponseDataFromResultsData: (NSData *) resultsData
{
	return [UIImage imageWithData: resultsData];
}

+(void) setShouldCacheImages: (BOOL) shouldCacheImages
{
	__imageRequestShouldCacheImages = shouldCacheImages;
}

-(void) requestWillSend
{
    //temporary auth during development
	[self.urlRequest setValue: @"Basic c3RhZ2V1c2VyOnN0NGczYm94" forHTTPHeaderField: @"Authorization"];
}

@end
