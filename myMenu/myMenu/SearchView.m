//
//  SearchView.m
//  myMenu
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SearchView.h"
#import "SSCheckBoxView.h"
@implementation SearchView
@synthesize keywordSearchTV;
@synthesize searchLabel;
@synthesize runDefaultSearchLabel;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void) viewDidLoad
{
    self.keywordSearchTV.layer.cornerRadius = 10.;
    [self.keywordSearchTV setClipsToBounds:YES];
    self.keywordSearchTV.text = @"Keyword Search";
    self.keywordSearchTV.textColor = [UIColor lightGrayColor];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Search"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc] initWithString:@"Run Default Search Profile"];
    [attributeString2 addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString2 length]}];
    self.runDefaultSearchLabel.attributedText = [attributeString2 copy];
    self.searchLabel.attributedText = [attributeString copy];
    SSCheckBoxView *cbv = nil;
    CGRect frame = CGRectMake(270, 115, 50, 30);
    cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                            checked:NO];
    [self addSubview:cbv];
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.keywordSearchTV.text = @"";
    self.keywordSearchTV.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.keywordSearchTV.text.length == 0){
        self.keywordSearchTV.textColor = [UIColor lightGrayColor];
        self.keywordSearchTV.text = @"Keyword Search";
        [self.keywordSearchTV resignFirstResponder];
    }
}
- (IBAction)pressedCancel:(id)sender {
    [self.delegate SearchViewDidFinish];
}

@end
