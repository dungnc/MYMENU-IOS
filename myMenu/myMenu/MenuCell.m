//
//  MenuCell.m
//  myMenu
//
//  Created by Judge Man on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "MenuCell.h"
@interface MenuCell()

@end
@implementation MenuCell
@synthesize nameLB;
+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}
-(void) awakeFromNib {
    [super awakeFromNib];
    self.nameLB.font = [UIFont boldSystemFontOfSize:19.0f];
}
/*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}*/

/*- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}/*/

@end
