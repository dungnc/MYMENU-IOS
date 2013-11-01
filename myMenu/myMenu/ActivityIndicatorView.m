//
//  ActivityIndicatorView.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//
#import "ActivityIndicatorView.h"
#import "NSBundle+Additions.h"
#import <QuartzCore/QuartzCore.h>


@interface ActivityIndicatorView()
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end


@implementation ActivityIndicatorView

-(id) initWithCoder: (NSCoder *) coder
{
	if ((self = [super initWithCoder: coder])) {
		[self initComplete];
	}
	return self;
}


-(id) initWithFrame: (CGRect) frame
{
	if ((self = [super initWithFrame: frame])) {
		[self initComplete];
	}
	return self;
}


-(void) initComplete
{
    [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: self superview: self];
    
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didRotate)
                                                 name: UIDeviceOrientationDidChangeNotification
                                               object: nil];
    
    self.layer.cornerRadius = 10.;
    _label.font = [UIFont boldSystemFontOfSize: 17.0];
}


-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}


-(void) didRotate
{
	[self setRotationAnimated: YES];
}


-(void) startWithMessage: (NSString *)message
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    [_activityIndicator startAnimating];
    _label.text = message;
}


-(void) stop
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
    [_activityIndicator stopAnimating];
}


-(void) setRotationAnimated: (BOOL)animated
{
    CGFloat angle = 0;
	switch ([[UIApplication sharedApplication] statusBarOrientation]) {
		case UIInterfaceOrientationLandscapeLeft: angle = -90; break;
		case UIInterfaceOrientationLandscapeRight: angle = 90; break;
		case UIInterfaceOrientationPortraitUpsideDown: angle = 180; break;
		default: break;
	}
    
    [UIView animateWithDuration: 0.4
                     animations:^{
                         self.layer.affineTransform = CGAffineTransformMakeRotation(angle * M_PI / 180.0);
                     }];
}

@end
