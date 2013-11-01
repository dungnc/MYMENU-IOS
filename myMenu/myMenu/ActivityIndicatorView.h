//
//  ActivityIndicatorView.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//
@interface ActivityIndicatorView : UIView
-(void) startWithMessage: (NSString *)message;
-(void) stop;
-(void) setRotationAnimated: (BOOL)animated;
@end
