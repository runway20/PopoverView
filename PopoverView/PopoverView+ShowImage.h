//
// Created by Jindrich Dolezy on 13.03.14.
//

#import <Foundation/Foundation.h>
#import "PopoverView.h"

@interface PopoverView (ShowImage)

#pragma mark - Custom Image Showing

//Animate in, and display the image provided here.
- (void)showImage:(UIImage *)image withMessage:(NSString *)msg;

//Animate in at specific duration, and display the image provided here.
- (void)showImage:(UIImage *)image withMessage:(NSString *)msg duration:(NSTimeInterval)duration;

#pragma mark - Error/Success Methods

//Shows (and animates in) an error X in the contentView
- (void)showError;

//Shows (and animates in) a success checkmark in the contentView
- (void)showSuccess;

@end