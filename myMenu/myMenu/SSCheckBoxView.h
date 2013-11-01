//
//  SSCheckBoxView.h
//  SSCheckBoxView
//
//  Created by Judge Man on 10/31/13.
//  Copyright (c) 2013 Magrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSCheckBoxView: UIView
{

    BOOL checked;
    BOOL enabled;
    UIImageView *checkBoxImageView;
    SEL stateChangedSelector;
    id<NSObject> delegate;
    void (^stateChangedBlock)(SSCheckBoxView *cbv);
}

@property (nonatomic, readonly) BOOL checked;
@property (nonatomic, getter=enabled, setter=setEnabled:) BOOL enabled;
@property (nonatomic, copy) void (^stateChangedBlock)(SSCheckBoxView *cbv);

- (id) initWithFrame:(CGRect)frame
             checked:(BOOL)aChecked;

- (void) setChecked:(BOOL)isChecked;

- (void) setStateChangedTarget:(id<NSObject>)target
                      selector:(SEL)selector;

@end
