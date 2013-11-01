//
//  LocationObject.h
//  myMenu
//
//  Created by HoaTruong on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationObject_hoa : NSObject
@property (nonatomic, strong) NSArray *images;
- (NSArray *)arrayImage;
- (NSString *)contentTitle:(NSInteger) index;
- (NSString *)contentNote:(NSInteger) index;
- (NSString *)contentDescription:(NSInteger) index;
@end
