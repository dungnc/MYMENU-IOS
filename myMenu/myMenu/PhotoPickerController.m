//
//  PhotoPickerController.m
//  Intelligent Menu
//
//  Created by RYAN VANALSTINE on 1/28/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//

#import "PhotoPickerController.h"

typedef enum {
    cameraPicker,
    photoAlbumPicker
} PickerType;

@interface PhotoPickerController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIActionSheet *photoActionSheet;
@property (nonatomic, assign) PickerType pickerType;
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation PhotoPickerController
@synthesize photoActionSheet;
@synthesize pickerType;
@synthesize viewController;
@synthesize delegate;

+(PhotoPickerController *) sharedController {
    static PhotoPickerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)showPickerActionSheetInView:(UIViewController *)theViewController {
    self.photoActionSheet = nil;
    self.viewController = theViewController;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        self.photoActionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"Take New Photo", @"Choose From Library", nil];
        self.photoActionSheet.tag = 10;
    } else {
        self.photoActionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"Choose From Library",nil];
        self.photoActionSheet.tag = 11;
    }
    
    self.photoActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.photoActionSheet showInView:viewController.view];
}
- (void)showPickerActionSheetWithNoPhotoOptionInView:(UIViewController *)theViewController {
    self.photoActionSheet = nil;
    self.viewController = theViewController;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        self.photoActionSheet = [[UIActionSheet alloc]
                                 initWithTitle:nil
                                 delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:@"Take New Photo", @"Choose From Library", @"No Photo", nil];
        self.photoActionSheet.tag = 10;
    } else {
        self.photoActionSheet = [[UIActionSheet alloc]
                                 initWithTitle:nil
                                 delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:@"Choose From Library",@"No Photo", nil];
        self.photoActionSheet.tag = 11;
    }
    
    self.photoActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.photoActionSheet showInView:viewController.view];
}

#pragma mark Choose Photo methods and Image Picker callbacks
- (void)showAcquirePictureUI:(bool)existingPhotoFromRoll {
	if (existingPhotoFromRoll) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self openPhotoPicker];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Photo Library Error" message:@"Cannot access the photo library on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
            self.pickerType = cameraPicker;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.showsCameraControls = YES;
            [self.viewController presentViewController:picker animated:YES completion:nil];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Camera Error" message:@"Cannot access the camera on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selectedImage = nil;
        if (self.pickerType == photoAlbumPicker) {
            selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            if (self.delegate) {
                [self.delegate libraryImageSelected:selectedImage];
            }
        } else {
            selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
            UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
            //selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            if (self.delegate) {
                [self.delegate imageSelected:selectedImage];
            }
        }
    }];
   
	return;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)openPhotoPicker {
    self.pickerType = photoAlbumPicker;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
	CGContextTranslateCTM(currentContext, 0.0, rect.size.height);
	CGContextScaleCTM(currentContext, 1.0, -1.0);
    
	CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
	CGContextClipToRect( currentContext, clippedRect);
	CGRect drawRect = CGRectMake(rect.origin.x * -1,rect.origin.y * -1,imageToCrop.size.width,imageToCrop.size.height);
	CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
	CGContextScaleCTM(currentContext, 1.0, -1.0);
    
	UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return cropped;
}

#pragma mark Action Sheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.photoActionSheet = nil;
    if (actionSheet.tag == 10) {
		if (buttonIndex == 0) {
			[self showAcquirePictureUI:NO];
		} else if (buttonIndex == 1) {
			[self showAcquirePictureUI:YES];
		} else if (buttonIndex == 3) {
			return;
		} else {
            if (self.delegate) {
                [self.delegate resetCurrentImage];
            }
		}
        
	} else if (actionSheet.tag == 11) {
		if (buttonIndex == 0) {
			[self showAcquirePictureUI:YES];
		} else if (buttonIndex == 2) {
			return;
		} else {
            if (self.delegate) {
                [self.delegate resetCurrentImage];
            }
		}
	}
}
@end
