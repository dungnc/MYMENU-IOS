//
//  NSBundle+Additions.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "NSBundle+Additions.h"
#import "UIView+HierarchyAdditions.h"


@implementation NSBundle(Additions)

-(NSArray *) loadNibNamed: (NSString *)	nibName
					owner: (id) owner
				superview: (UIView *) superview
{
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed: nibName owner: owner options: nil];
	
	NSAssert( topLevelObjects.count == 1, @"Only works with a single top level object (todo: specify the top-level object by name)" );
	UIView *rootView = topLevelObjects[0];
	CGRect superviewOriginalFrame = superview.frame;
	superview.frame = CGRectMake( superview.frame.origin.x, superview.frame.origin.y, rootView.frame.size.width, rootView.frame.size.height );
	superview.autoresizesSubviews = rootView.autoresizesSubviews;
	superview.autoresizingMask = rootView.autoresizingMask;
    superview.backgroundColor = rootView.backgroundColor;
    superview.alpha = rootView.alpha;
    superview.userInteractionEnabled = rootView.userInteractionEnabled;
    superview.multipleTouchEnabled = rootView.multipleTouchEnabled;
    superview.clipsToBounds = rootView.clipsToBounds;
    superview.opaque = rootView.opaque;
    superview.hidden = rootView.hidden;
    superview.clearsContextBeforeDrawing = rootView.clearsContextBeforeDrawing;
    superview.contentMode = rootView.contentMode;
    superview.tag = rootView.tag;
	
	NSArray *viewsToReparent = [[rootView allSubviews] filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"superview == %@", rootView]];
	for (UIView *viewToReparent in viewsToReparent) {
		[viewToReparent removeFromSuperview];
		[superview addSubview: viewToReparent];
	}
	superview.frame = superviewOriginalFrame;
	
	return topLevelObjects;
}

@end
