//
//  MyMenuAppController.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "MyMenuAppController.h"
#import "ActivityIndicatorView.h"
#import "LoginViewController.h"
#import "UIView+FrameAdditions.h"
@interface MyMenuAppController ()
@property (nonatomic, strong) ActivityIndicatorView *activityIndicatorView;

@end
@implementation MyMenuAppController

+ (MyMenuAppController *) sharedController {
    static MyMenuAppController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}
- (void)showAlertViewWithMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:message
                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}
- (void)setBackgroundImageForViewController:(UIViewController *)viewController {
    NSString *imageName = nil;
   
    if ([viewController isKindOfClass:[LoginViewController class]]) {
        imageName = @"login_bg";
        if(IS_IPHONE5)
        {
            imageName = @"login_bg_ip5";
        }
    }
    imageName = [imageName stringByAppendingString:@".jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = viewController.view.frame;
    [imageView setFrameHeight:480.];
    
    if (IS_IPHONE5) {
        [imageView setFrameHeight:568.];
    }
    
    imageView.contentMode = UIViewContentModeScaleToFill;
    [viewController.view addSubview:imageView];
    [viewController.view sendSubviewToBack:imageView];
}
- (NSArray *)sortArrayBasedOnDistance:(NSArray *) array {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [array sortedArrayUsingDescriptors:sortDescriptors];
}
- (CGFloat)locationDistanceInMilesFromCLLocation2D:(CLLocationCoordinate2D)location {
    CLLocationCoordinate2D current;
    current.latitude = 30.2669;
    current.longitude = -97.7428;
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:current.latitude longitude:current.longitude];
    CLLocation *venueLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    return [currentLocation distanceFromLocation:venueLocation] / 1609.344;
}
#pragma mark Activity Indicator Methods
-(ActivityIndicatorView *) activityIndicatorView {
    if (!_activityIndicatorView) {
        self.activityIndicatorView = [[ActivityIndicatorView alloc] initWithFrame: CGRectMake(0., 0., 150., 100.)];
    }
    return _activityIndicatorView;
}
-(void) showActivityIndicatorInView: (UIView *)view withMessage: (NSString *)message {
    if (!view || ![message length]) {
        return;
    }
    // this is dispatched because the device orientation is undetermined in the very first run loop
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView setRotationAnimated: NO];
        [[[UIApplication sharedApplication] keyWindow] addSubview: self.activityIndicatorView];
        [self.activityIndicatorView startWithMessage: message];
        self.activityIndicatorView.center = [[UIApplication sharedApplication] keyWindow].center;
    });
}
-(void) showLoadingViewInView: (UIView *)view {
    [self showActivityIndicatorInView: view withMessage: @"Loading..."];
}
-(void) removeActivityIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView removeFromSuperview];
        [self.activityIndicatorView stop];
    });
}
@end
