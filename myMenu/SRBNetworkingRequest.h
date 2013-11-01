#import <Foundation/Foundation.h>

@class SRBNetworkingRequest;

typedef id (^SRBNetworkingRequestCreateModelObjectBlock)( id responseData );						
typedef void (^SRBNetworkingRequestCompletionBlock)(SRBNetworkingRequest *request);	

@interface SRBNetworkingRequest : NSOperation<NSURLConnectionDelegate>										// subclasses can tweak NSURLConnectionDelegate methods

@property (nonatomic, assign)	dispatch_queue_t							requestCompletionQueue;			// optional; default is the main queue
@property (nonatomic, copy)		SRBNetworkingRequestCompletionBlock			requestCompletionBlock;			// called when the operation is complete.  results are accessed via -resultsError & -modelObject
@property (nonatomic, copy) 	SRBNetworkingRequestCreateModelObjectBlock	createModelObjectBlock;			// optional; called to format the -modelObject from the returned NSData

@property (nonatomic, strong)   NSMutableDictionary                         *parameters;
@property (nonatomic, readonly)	NSMutableDictionary							*userInfo;						// optional; info along with the request
@property (nonatomic, strong)	NSString									*resourcePath;					// optional; typically specified via designated initializer
@property (nonatomic, readonly)	NSInteger									requestID;						// unique auto-generated ID for this request
@property (nonatomic, readonly)	NSMutableURLRequest 						*urlRequest;          			// modify to your hearts content
@property (nonatomic, assign)	BOOL										shouldCacheResult;				// optional; default is NO. Support for caching found at SRBNetworkingClient

// results returned from NSURLConnection
@property (nonatomic, strong) 	NSMutableData   					    	*resultsData;                	// raw data as returned from NSURLConnection via data accumulator
@property (nonatomic, strong) 	NSError             						*resultsError;               	// as returned from NSURLConnection
@property (nonatomic, strong)	NSHTTPURLResponse							*urlResponse;					// raw response from the NSURLConnection; -statusCode is useful

// formatted response 
@property (nonatomic, strong)	id											modelObject;					// created from the createModelObjectBlock 
@property (nonatomic, strong)	id											formattedResponseData;			// this is the result of the conversion from NSData; here as a reference if it's needed later (e.g. direct access to NSDictionary returned from web svc)
@property (nonatomic, assign)	BOOL										wasSatisfiedViaCache;			

+(id) requestWithBaseURL: (NSURL *) baseURL resourcePath: (NSString *) resourcePath;
-(id) initWithBaseURL: (NSURL *) baseURL resourcePath: (NSString *) resourcePath;

-(void) addParameterNamed: (NSString *) paramName value: (id) object;										// URL is computed via baseURL, resourcePath and parameters (last 2 are optional)
-(void) addPostValueNamed: (NSString *) paramName value: (id) object;

-(BOOL) hasError;																							// default returns resultsError != nil; useful for culling an application API level fault that also qualifies as an error, override to add application logic

// for subclasses
-(id) formattedResponseDataFromResultsData: (NSData *) resultsData;											// optional; e.g. NSData > JSON NSDictionary for all request types of this class; default returns the NSData
-(void) requestWillSend;																					// optional; perfect time to mod the urlRequest
-(void) requestDidComplete;																					// optional; useful for performing common request completion code (web service common faults from return data, etc)

// for debugging
-(NSString *) postParameterFragment;

@end
