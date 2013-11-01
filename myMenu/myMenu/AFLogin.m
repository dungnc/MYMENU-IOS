//
//  AFLogin.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "AFLogin.h"
#import "AFJSONRequestOperation.h"
#import "AFAppClient.h"
#import "MyMenuAppController.h"
@implementation AFLogin
@synthesize delegate = _delegate;
@synthesize jsonResult = _jsonResult;

- (void) login:(NSDictionary*)params and:(NSString*)path{
    [[AFAppClient sharedClient]postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _jsonResult = responseObject;
        [self.delegate returnInfoAfterLogin:_jsonResult];
        [[MyMenuAppController sharedController] removeActivityIndicator];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[MyMenuAppController sharedController] removeActivityIndicator];
        [[[UIAlertView alloc] initWithTitle:@"Incorrect email or password" message:@"Please try again." delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles:nil] show];
        
    }];
}

@end
