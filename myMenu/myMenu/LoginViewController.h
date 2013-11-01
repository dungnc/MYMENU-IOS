//
//  LoginViewController.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFLogin.h"
@class LoginViewController;

@protocol LoginViewControllerDelegate
- (void)LoginViewControllerDidFinish:(LoginViewController *)controller;
- (void) returnInfoToHomeViewController:(NSDictionary*) JSON ;
@end
@interface LoginViewController : UIViewController <AFLoginDelegate>
@property (nonatomic, retain) NSDictionary * jsonResult;
@property (nonatomic, assign) id <LoginViewControllerDelegate> delegate;
@end
