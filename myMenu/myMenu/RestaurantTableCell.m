//
//  RestaurantTableCell.m
//  myMenu
//
//  Created by Judge Man on 10/28/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "RestaurantTableCell.h"
#import "LocationObject.h"
//#import "NSString+ObjectFormatters.h"

@interface RestaurantTableCell ()
@property (nonatomic, weak) IBOutlet UILabel *restaurantName;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@end

@implementation RestaurantTableCell
@synthesize location;
@synthesize indexPathRow;

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}
-(void) awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 5.;
    [self.icon setClipsToBounds:YES];
    self.restaurantName.font = [UIFont boldSystemFontOfSize:19.0f];
    self.distanceLabel.font = [UIFont boldSystemFontOfSize:14.0f];
}

#pragma mark Overrides
- (void)setLocation:(LocationObject *)theLocation {
    location = theLocation;

    if (self.location.name) {
        self.restaurantName.text = self.location.name;
    }
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", self.location.distance];

}
- (void)setIndexPathRow:(NSInteger)theIndexPathRow {
    indexPathRow = theIndexPathRow;
    
    if (self.indexPathRow == 0) {

    }


}
@end
