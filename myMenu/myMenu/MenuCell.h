//
//  MenuCell.h
//  myMenu
//
//  Created by Judge Man on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *nameLB;
+ (NSString *)reuseIdentifier;
@end
