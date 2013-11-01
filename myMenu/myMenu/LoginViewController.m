//
//  LoginViewController.m
//  myMenu
//
//  Created by Judge Man on 10/24/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "LoginViewController.h"
#import "Reachability.h"
#import "NSString+EmailValidation.h"
#import "MyMenuAppController.h"
@interface LoginViewController (){
    NetworkStatus internetStatus;
}
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@end

@implementation LoginViewController
@synthesize jsonResult = _jsonResult;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[MyMenuAppController sharedController] setBackgroundImageForViewController:self];
    }
    return self;
}

- (void) returnInfoAfterLogin:(NSDictionary*) JSON {
    _jsonResult = JSON;
    if([_jsonResult objectForKey:@"access_token"]){
        [self.delegate LoginViewControllerDidFinish:self];
        [self.delegate returnInfoToHomeViewController:_jsonResult];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    internetStatus = [reachability currentReachabilityStatus];
}

- (IBAction)pressedLogin:(id)sender {
    if (internetStatus != NotReachable){
        if (self.emailTF.text.length == 0 || ![self.emailTF.text isValidEmailAddress]) {
             [[[UIAlertView alloc] initWithTitle:@"Invalid Email Address" message:@"Please Enter Again." delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles:nil] show];
            return;
        }
        if (self.passTF.text.length == 0) {
             [[[UIAlertView alloc] initWithTitle:@"Invalid password" message:@"Please enter your password" delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles:nil] show];
            return;
        }
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:self.emailTF.text, @"email", self.passTF.text, @"password", nil];
        AFLogin *aflogin = [AFLogin new];
        aflogin.delegate = self;
        [aflogin login:params and:kAPILoginPath];
         [[MyMenuAppController sharedController] showActivityIndicatorInView:self.view withMessage:@"Logging in..."];
    }
    else
        [[[UIAlertView alloc] initWithTitle:@"No Network Connection" message:@"Please try again." delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles:nil] show];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField==self.emailTF){
        [self.passTF becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
