//
//  ViewController.h
//  myMenu
//
//  Created by Judge Man on 10/23/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ViewController : UIViewController<LoginViewControllerDelegate,UISearchBarDelegate>
@property (nonatomic,retain) NSDictionary *jsonResult;
@property (nonatomic,retain) LoginViewController *loginView;
@end
