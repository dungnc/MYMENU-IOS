//
//  UIView+HierarchyAdditions.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "UIView+HierarchyAdditions.h"

@implementation UIView(HierarchyAdditions)

-(NSArray *) allSubviewsForView: (UIView *) view
{
	NSMutableArray *subviews = [NSMutableArray array];
	[subviews addObject: view];
	for ( UIView *subview in view.subviews )
	{
		[subviews addObjectsFromArray: [self allSubviewsForView: subview]];
	}
	return [NSArray arrayWithArray: subviews];
}


-(NSArray *) allSubviews
{
	return [self allSubviewsForView: self];
}


@end
