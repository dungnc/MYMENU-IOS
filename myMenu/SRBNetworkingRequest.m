#import "SRBNetworkingRequest.h"

static NSInteger __SRBNetworkingLastRequestID = 1;


@interface SRBNetworkingRequest()
@property (nonatomic, strong)   			NSURL               	*baseURL;
@property (nonatomic, strong)   			NSURLConnection     	*connection;          
@property (nonatomic, strong)               NSMutableDictionary     *postParameters;
@property (nonatomic, readwrite)	NSMutableDictionary		*userInfo;
@property (nonatomic, readwrite)	NSInteger				requestID;
@property (nonatomic, strong)				NSDate					*enqueuedTime;
@property (nonatomic, strong)				NSDate					*startedTime;
@property (nonatomic, strong)				NSDate					*endedTime;
@property (nonatomic, readwrite)            NSMutableURLRequest     *urlRequest;
@end


@implementation SRBNetworkingRequest

+(id) requestWithBaseURL: (NSURL *) baseURL resourcePath: (NSString *) resourcePath
{
	return [[self alloc] initWithBaseURL: baseURL resourcePath: resourcePath];
}

-(id) initWithBaseURL: (NSURL *) baseURL resourcePath: (NSString *) resourcePath
{
	if ( (self = [super init]) )
	{
		self.shouldCacheResult = NO;
		self.baseURL = baseURL;
		self.resourcePath = resourcePath;
		self.parameters = [NSMutableDictionary dictionary];
        self.postParameters = [NSMutableDictionary dictionary];
		self.userInfo = [NSMutableDictionary dictionary];
		self.resultsData = [NSMutableData data];
		self.requestID = __SRBNetworkingLastRequestID++;
		self.enqueuedTime = [NSDate date];								// well, not 100% true, but it's a relatively safe bet the request is enqueued nearly right away...
		self.requestCompletionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);		// safe initial assumption; we want to return the data to the calling queue.  Can be overridden.
	}
	return self;
}

-(void) addParameterNamed: (NSString *) paramName value: (id) object
{
	if ( !paramName )
		return;
	
	if ( !object ) object = @"";
	
	(self.parameters)[paramName] = object;
}

-(void) addPostValueNamed: (NSString *) paramName value: (id) object
{
    if ( !paramName )
		return;
	
	if ( !object ) object = @"";
	
	(self.postParameters)[paramName] = object;
}

-(BOOL) hasError
{
	return self.resultsError != nil;
}


-(NSMutableURLRequest *) urlRequest
{
	if ( !_urlRequest )
	{
		NSURL *absoluteURL = [self absoluteURL];
		if ( absoluteURL )
		{
			_urlRequest = [[NSMutableURLRequest alloc] initWithURL: absoluteURL];
		}
        
        if ( [self.postParameters count] )
        {
            _urlRequest.HTTPMethod = @"POST";
            _urlRequest.HTTPBody = [[self postParameterFragment] dataUsingEncoding: NSUTF8StringEncoding];
        }
	}
	return _urlRequest;
}


#pragma mark- Internal Methods

-(NSURL *) absoluteURL
{
	NSString *fragment = [self parameterFragment];
	
	NSMutableString *formattedURLString = [NSMutableString string];
	if ( [[[self baseURL] absoluteString] length] )
	{
		[formattedURLString appendString: [[self baseURL] absoluteString]];
	}
	if ( [[self resourcePath] length] )
	{
		[formattedURLString appendString: [self resourcePath]];
	}
	if ( [fragment length] )
	{
		[formattedURLString appendString: fragment];
	}
	return [NSURL URLWithString: formattedURLString];
}

-(NSString *) parameterFragment
{
    return [self parameterFragmentWithDictionary: self.parameters];
}

-(NSString *) postParameterFragment
{
    NSString *fragment = [self parameterFragmentWithDictionary: self.postParameters];
    if ( [fragment rangeOfString: @"?"].location == 0 )
    {
        return [fragment substringFromIndex: 1];
    }
    return fragment;
}

-(NSString *) parameterFragmentWithDictionary: (NSDictionary *)dict
{
	NSMutableString *fragment = [NSMutableString stringWithString:@""];
	
	for ( NSString *paramName in dict )
	{
		id value = dict[paramName];
		if ( [value isKindOfClass: [NSArray class]] )
		{
			value = [(NSArray *)value componentsJoinedByString: @","];
		}
		NSString *escapedValue = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
																									   (__bridge CFStringRef)value,
																									   NULL, 
																									   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																									   kCFStringEncodingUTF8);
		NSString *separator = [fragment length] == 0 ? @"?" : @"&";
		[fragment appendFormat: @"%@%@=%@", separator, paramName, escapedValue];
	}
	return [NSString stringWithString: fragment];
}

-(void) main
{
	if ([self isCancelled]) 
		return;
	
	self.startedTime = [NSDate date];
	[self requestWillSend];
	self.connection = [NSURLConnection connectionWithRequest: self.urlRequest delegate: self];
	CFRunLoopRun();
	self.endedTime = [NSDate date];
	
	if ( !self.isCancelled )
		[self requestDidComplete];
}

#pragma mark- NSURLConnectionDelegate

- (void)finish
{
	CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	if ([self isCancelled]) 
	{
		[self.connection cancel];
		[self finish];
		return;
	}
	[self finish];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)resp
{
    self.urlResponse = resp;
	if ([self isCancelled]) 
	{
		[self.connection cancel];
		[self finish];
		return;
	}
	self.resultsData = [NSMutableData data];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)newData
{
	if ([self isCancelled]) 
	{
		[self.connection cancel];
		[self finish];
		return;
	}
	[self.resultsData appendData:newData];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
	if ([self isCancelled]) 
	{
		[self.connection cancel];
		[self finish];
		return;
	}
	self.resultsError = error;
	[self finish];
}


#pragma mark- Overrides

-(id) formattedResponseData
{
    if (!_formattedResponseData) {
        self.formattedResponseData = [self formattedResponseDataFromResultsData: self.resultsData];
    }
    return _formattedResponseData;
}


-(id) formattedResponseDataFromResultsData: (NSData *) resultsData
{
	return resultsData;
}

-(void) requestWillSend
{
}

-(void) requestDidComplete
{
	//self.formattedResponseData = [self formattedResponseDataFromResultsData: self.resultsData];
	
	// create our model object, if we have a supplied block.
	if ( self.createModelObjectBlock  )
	{
		if ( !self.isCancelled && !self.resultsError ) 
		{
			self.modelObject = self.createModelObjectBlock( self.formattedResponseData );
		}
	}
	// otherwise, skip this step and the model object is our -preprocessResponseData results
	else 
	{
		self.modelObject = self.formattedResponseData;
	}
	//DLog( @"request stats: viaCache [%d] waitedInQueue [%f] executionTime [%f]  id [%d] resource [%@]", self.wasSatisfiedViaCache, [self.startedTime timeIntervalSinceDate: self.enqueuedTime], [self.endedTime timeIntervalSinceDate: self.startedTime], self.requestID, self.resourcePath.length ? self.resourcePath : self.urlRequest.URL  );
}


@end


