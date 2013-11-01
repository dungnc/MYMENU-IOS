//
//  RestaurantDetailViewController.h
//  myMenu
//
//  Created by HoaTruong on 10/28/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationObject_hoa;
@class RestaurantDetailObject;
@interface RestaurantDetailViewController : UIViewController
@property (nonatomic, strong) LocationObject_hoa *location;
@property (nonatomic, strong) RestaurantDetailObject *restanrantDetail;
@end
