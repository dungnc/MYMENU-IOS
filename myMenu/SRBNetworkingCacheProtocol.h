#import <Foundation/Foundation.h>

// NSCache responds to these, making it a drop-in replacement.  (Alternatively, you can supply any class you want that conforms to this.)

@protocol SRBNetworkingCacheProtocol <NSObject>
@required

-(id) objectForKey: (id) key;
-(void) setObject: (id) obj forKey: (id) key;

@end
