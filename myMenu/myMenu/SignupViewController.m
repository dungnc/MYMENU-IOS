//
//  SignupViewController.m
//  myMenu
//
//  Created by HoaTruong on 10/29/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import "SignupViewController.h"
#import "PhotoPickerController.h"
#import "MyMenuAppController.h"
#import "NSString+EmailValidation.h"
#import "UserObject.h"
@interface SignupViewController ()<  PhotoPickerDelegate >
@property (nonatomic, strong) UIActionSheet *currentActionSheet;
@property (nonatomic, strong) NSArray *genderArray;
@property (nonatomic, strong) UIPickerView *genderPicker;
@property (nonatomic, strong) UIImage *userIcon;
@property (nonatomic, strong) UserObject *currentUser;
//@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeField;
//@property (weak, nonatomic) IBOutlet UITextField *cityField;
//@property (weak, nonatomic) IBOutlet UITextField *stateField;
//@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;

@end

@implementation SignupViewController
@synthesize _iMenuAppController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _iMenuAppController = [[MyMenuAppController alloc] init];
    self.genderArray = @[@"Male", @"Female"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)checkAccount {
    self.currentUser = [[UserObject alloc] init];
    NSDictionary *dictionary = self.currentUser.userAccount;
    BOOL results =([self.emailAddressField.text isEqualToString:[dictionary objectForKey:@"emailAddress"]])? YES:NO;
    return results;
}


//#pragma mark UPickerView Delegates
//- (void)displayPicker {
//    self.currentActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    self.genderPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
//    self.genderPicker.showsSelectionIndicator = YES;
//    self.genderPicker.delegate = self;
//   UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
//	pickerToolbar.barStyle = UIBarStyleBlack;
//	[pickerToolbar sizeToFit];
//	
//	NSMutableArray *barItems = [[NSMutableArray alloc] init];
//	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPickerButtonPressed)];
//	[barItems addObject:cancelButton];
//	
//	UIBarButtonItem *flexRightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//	[barItems addObject:flexRightSpace];
//	
//	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePickerButtonPressed:)];
//	[barItems addObject:doneButton];
//	doneButton.enabled = YES;
//	
//    [pickerToolbar setItems:barItems animated:NO];
//    [self.currentActionSheet addSubview:pickerToolbar];
//	[self.currentActionSheet addSubview:self.genderPicker];
//	[self.currentActionSheet showInView:self.view];
//	[self.currentActionSheet setBounds:CGRectMake(0.0, 0.0, 320.0, 464.0)];
//    
//}
//- (void)cancelPickerButtonPressed {
//	if (self.currentActionSheet != nil) {
//		[self.currentActionSheet dismissWithClickedButtonIndex:0 animated:YES];
//		self.currentActionSheet = nil;
//	}
//}
//- (void)savePickerButtonPressed:(id)sender {
//    if (self.currentActionSheet != nil) {
//		[self.currentActionSheet dismissWithClickedButtonIndex:0 animated:YES];
//		self.currentActionSheet = nil;
//	}
//    NSInteger index = [self.genderPicker selectedRowInComponent:0];
//   self.genderField.text= [self.genderArray objectAtIndex:index];
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [self.genderArray objectAtIndex:row];
//}
//// tra ve so ldu lieu co trong picker
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return self.genderArray.count;
//}
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1; // or 2 or more
//}
//- (IBAction)gerderButton:(id)sender {
////    [self displayPicker];
//}
#pragma mark Photo Picker Delegates
- (void)setUserIconDateWithImage:(UIImage *)image {
    self.iconImage.image = image;
}
- (void)resetCurrentImage {
    self.userIcon = nil;
    self.iconImage.image = [UIImage imageNamed:@"avatar_placeholder.jpeg"];
}
- (void)imageSelected:(UIImage *)image {
    [self setUserIconDateWithImage:image];
}
- (void)libraryImageSelected:(UIImage *)image {
    [self setUserIconDateWithImage:image];
}
#pragma mark TextField Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (textField == self.passwordField ||
        textField == self.confirmPasswordField)  {
        const int movementDistance = 160; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.firstNameField) {
        [self.lastNameField becomeFirstResponder];
    } else if (textField == self.lastNameField) {
        [self.emailAddressField becomeFirstResponder];
    } else if (textField == self.emailAddressField) {
        [self.usernameField becomeFirstResponder];
    } else if (textField == self.usernameField) {
        [self.zipCodeField becomeFirstResponder];
    } else if(textField == self.zipCodeField){
        [self.passwordField becomeFirstResponder];
        //    }else if (textField == self.cityField) {
        //        [self.stateField becomeFirstResponder];
        //    } else if (textField == self.stateField) {
        //        [self.ageField becomeFirstResponder];
        //    } else if (textField == self.ageField) {
        //        [self.ageField resignFirstResponder];
        //   [self displayPicker];
    }else if (textField == self.passwordField) {
        [self.confirmPasswordField becomeFirstResponder];
    } else if (textField == self.confirmPasswordField) {
        [self.confirmPasswordField resignFirstResponder];
    }
    return  YES;
}
- (void)resignAllTextFields {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.emailAddressField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    [self.zipCodeField resignFirstResponder];
    //    [self.cityField resignFirstResponder];
    //    [self.stateField resignFirstResponder];
    //    [self.ageField resignFirstResponder];
    //    [self.genderField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.confirmPasswordField resignFirstResponder];
}
#pragma mark Action Methods
- (IBAction)addIconButtonPressed:(id)sender {
    [self resignAllTextFields];
    [PhotoPickerController sharedController].delegate = self;
    [[PhotoPickerController sharedController] showPickerActionSheetWithNoPhotoOptionInView:self];
    
}
- (IBAction)resignAllTextFieldsButton:(id)sender {
    [self resignAllTextFields];
}
- (IBAction)submitButton:(id)sender {
    if ([self checkAccount]) {
        [_iMenuAppController  showAlertViewWithMessage:@"account exists"];
        return;
    }
    if (self.firstNameField.text.length == 0) {
        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your first name"];
        return;
    }
    
    if (self.lastNameField.text.length == 0) {
        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your last name"];
        return;
    }
    
    if (self.emailAddressField.text.length == 0 /*|| ![self.emailAddressField.text isValidEmailAddress]*/)
    {
        //NSLog(@"loi o day");
         [_iMenuAppController  showAlertViewWithMessage:@"Please enter a valid email address"];
        return;
    }
    
    if (self.usernameField.text.length == 0) {
        [_iMenuAppController  showAlertViewWithMessage:@"Please enter a username"];
        return;
    }
//    
//    if (self.cityField.text.length == 0) {
//        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your city"];
//        return;
//    }
//    if (self.ageField.text.length == 0) {
//        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your age"];
//        return;
//    }
//    
//    if (self.stateField.text.length == 0) {
//        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your state"];
//        return;
//    }
    
    if (self.passwordField.text.length == 0) {
        [_iMenuAppController  showAlertViewWithMessage:@"Please enter your password"];
        return;
    }
    
    if (self.confirmPasswordField.text.length == 0) {
        [_iMenuAppController  showAlertViewWithMessage:@"Please confirm your password"];
        return;
    }
    
    if (!([self.passwordField.text isEqualToString:self.confirmPasswordField.text])) {
        [_iMenuAppController  showAlertViewWithMessage:@"Your passwords do not match"];
        return;
    }
   
}

@end
