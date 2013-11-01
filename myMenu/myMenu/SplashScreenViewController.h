//
//  SplashScreenViewController.h
//  myMenu
//
//  Created by HoaTruong on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@class LocationObject_hoa;

@interface SplashScreenViewController : UIViewController
@property (nonatomic, strong) LocationObject_hoa *location;
@property (nonatomic, strong) LoginViewController *loginView;
@end
