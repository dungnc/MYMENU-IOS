//
//  MySearchViewController.h
//  myMenu
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"
@interface MySearchViewController : UIViewController<SearchViewDelegate>
@property (nonatomic,strong) NSArray *restaurantObjects;
@end
