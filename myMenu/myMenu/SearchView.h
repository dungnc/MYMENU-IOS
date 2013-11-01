//
//  SearchView.h
//  myMenu
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchView;

@protocol SearchViewDelegate
- (void)SearchViewDidFinish;
@end
@interface SearchView : UIView
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UILabel *runDefaultSearchLabel;
@property (strong, nonatomic) IBOutlet UITextView *keywordSearchTV;
@property (nonatomic, assign) id <SearchViewDelegate> delegate;
-(void) viewDidLoad;
@end
