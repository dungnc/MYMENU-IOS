//
//  UIView+FrameAdditions.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "UIView+FrameAdditions.h"


@implementation UIView (FrameAdditions)

-(void) setCenterXOffset: (CGFloat)xOffset
{
    CGPoint center = self.center;
    center.x = xOffset;
    self.center = center;
    
    BOOL shouldRound = self.frame.origin.x - (int)self.frame.origin.x >= 0.;
    if (shouldRound) {
        [self setFrameXOffset: floorf(self.frame.origin.x)];
    }
}


-(void) setFrameXOffset: (CGFloat)xOffset
{
    CGRect frame = self.frame;
    frame.origin.x = xOffset;
    self.frame = frame;
}


-(void) setFrameYOffset: (CGFloat)yOffset
{
    CGRect frame = self.frame;
    frame.origin.y = yOffset;
    self.frame = frame;
}


-(void) setFrameWidth: (CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


-(void) setFrameHeight: (CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
