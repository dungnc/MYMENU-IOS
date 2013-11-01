//
//  SSCheckBoxView.m
//  SSCheckBoxView
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "SSCheckBoxView.h"

static const CGFloat kHeight = 36.0f;

@interface SSCheckBoxView(Private)
- (UIImage *) loadCheckBoxImage:(BOOL)isChecked;
- (CGRect) imageViewFrameForCheckBoxImage:(UIImage *)img;
- (void) updateCheckBoxImage;
@end

@implementation SSCheckBoxView

@synthesize checked, enabled;
@synthesize stateChangedBlock;

- (id) initWithFrame:(CGRect)frame
             checked:(BOOL)aChecked
{
    frame.size.height = kHeight;
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }

    stateChangedSelector = nil;
    self.stateChangedBlock = nil;
    delegate = nil;
    checked = aChecked;
    self.enabled = YES;

    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    UIImage *img = [self loadCheckBoxImage:checked];
    CGRect imageViewFrame = [self imageViewFrameForCheckBoxImage:img];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:imageViewFrame];
    iv.image = img;
    [self addSubview:iv];
    checkBoxImageView = iv;
    return self;
}

- (void) setEnabled:(BOOL)isEnabled
{
    enabled = isEnabled;
    checkBoxImageView.alpha = isEnabled ? 1.0f: 0.6f;
}

- (BOOL) enabled
{
    return enabled;
}

- (void) setChecked:(BOOL)isChecked
{
    checked = isChecked;
    [self updateCheckBoxImage];
}

- (void) setStateChangedTarget:(id<NSObject>)target
                      selector:(SEL)selector
{
    delegate = target;
    stateChangedSelector = selector;
}


#pragma mark -
#pragma mark Touch-related Methods

- (void) touchesBegan:(NSSet *)touches
            withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }

    self.alpha = 0.8f;
    [super touchesBegan:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches
                withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }

    self.alpha = 1.0f;
    [super touchesCancelled:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches
            withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }

    // restore alpha
    self.alpha = 1.0f;

    // check touch up inside
    if ([self superview]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:[self superview]];
        CGRect validTouchArea = CGRectMake((self.frame.origin.x - 5),
                                           (self.frame.origin.y - 10),
                                           (self.frame.size.width + 5),
                                           (self.frame.size.height + 10));
        if (CGRectContainsPoint(validTouchArea, point)) {
            checked = !checked;
            [self updateCheckBoxImage];
            if (delegate && stateChangedSelector) {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector: stateChangedSelector withObject:self];
                #pragma clang diagnostic pop
            }
            else if (stateChangedBlock) {
                stateChangedBlock(self);
            }
        }
    }

    [super touchesEnded:touches withEvent:event];
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}


#pragma mark -
#pragma mark Private Methods

- (UIImage *) loadCheckBoxImage:(BOOL)isChecked
{
    NSString *suffix = isChecked ? @"on" : @"off";
    NSString *imageName = @"";
    imageName = @"cb_glossy_";
    imageName = [NSString stringWithFormat:@"%@%@", imageName, suffix];
    return [UIImage imageNamed:imageName];
}

- (CGRect) imageViewFrameForCheckBoxImage:(UIImage *)img
{
    CGFloat y = floorf((kHeight - img.size.height) / 2.0f);
    return CGRectMake(5.0f, y, img.size.width, img.size.height);
}

- (void) updateCheckBoxImage
{
    checkBoxImageView.image = [self loadCheckBoxImage:checked];
}

@end
