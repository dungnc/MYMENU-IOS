//
//  PhotoPickerController.h
//  Intelligent Menu
//
//  Created by RYAN VANALSTINE on 1/28/13.
//  Copyright (c) 2013 Agile Poet, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PhotoPickerDelegate <NSObject>
@optional
- (void)resetCurrentImage;

@required
- (void)imageSelected:(UIImage *)image;
- (void)libraryImageSelected:(UIImage *)image;
@end

@interface PhotoPickerController : NSObject
@property (nonatomic, retain) id <PhotoPickerDelegate> delegate;

+(PhotoPickerController *) sharedController;
- (void)showPickerActionSheetInView:(UIViewController *)theViewController;
- (void)showPickerActionSheetWithNoPhotoOptionInView:(UIViewController *)theViewController;
@end
