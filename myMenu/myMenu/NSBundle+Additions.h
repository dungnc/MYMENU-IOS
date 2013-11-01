//
//  NSBundle+Additions.h
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

@interface NSBundle(Additions)

-(NSArray *) loadNibNamed: (NSString *)	nib							// load the nib, and reparent the view hierarchy to the specified superview
					owner: (id) owner
				superview: (UIView *) superview;

@end
