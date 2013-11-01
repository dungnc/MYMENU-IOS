//
//  RestaurantTableCell.h
//  myMenu
//
//  Created by Judge Man on 10/28/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationObject;

@interface RestaurantTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *iconIndicator;
@property (nonatomic, strong) LocationObject *location;
@property (nonatomic, assign) NSInteger indexPathRow;
+ (NSString *)reuseIdentifier;
@end
