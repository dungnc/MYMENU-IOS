//
//  MyMenuAppController.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface MyMenuAppController : NSObject
+(MyMenuAppController *) sharedController;
- (void)showAlertViewWithMessage:(NSString *)message;
- (void)setBackgroundImageForViewController:(UIViewController *)viewController;
- (NSArray *)sortArrayBasedOnDistance:(NSArray *) array;
- (CGFloat)locationDistanceInMilesFromCLLocation2D:(CLLocationCoordinate2D)location;
- (void)showActivityIndicatorInView: (UIView *)view withMessage: (NSString *)message;
-(void) showLoadingViewInView: (UIView *)view;
- (void)removeActivityIndicator;
@end
