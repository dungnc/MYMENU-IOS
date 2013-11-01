//
//  MyMenuView.h
//  myMenu
//
//  Created by Judge Man on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMenuView : UIView
@property (strong, nonatomic)  UILabel *points;
@property (strong, nonatomic)  UILabel *status;
@property (strong, nonatomic)  UILabel *userName;

-(void)viewDidLoad;
@end
