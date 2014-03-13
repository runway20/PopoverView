//
// Created by Jindrich Dolezy on 11.03.14.
//

#import <Foundation/Foundation.h>
#import "R20PopoverView.h"

@interface R20PopoverView (ShowMethods)

#pragma mark - Instance Showing Methods

// adds title label at the top. All methods below are internaly using this method
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView;


//Calls above method with a UILabel containing the text you deliver to this method.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text;

//Does same as above, but adds a title label at top of the popover.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text;


//Calls top method with an array of UIView objects.  This method will stack these views vertically
//with kBoxPadding padding between each view in the y-direction.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray;

//Does same as above, but adds a title label at top of the popover.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray;


//Calls the viewArray method with an array of UILabels created with the strings
//in stringArray.  All contents of stringArray must be NSStrings.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray;

//This method does same as above, but with a title label at the top of the popover.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray;


//Draws a vertical list of the NSString elements of stringArray with UIImages
//from imageArray placed centered above them.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray;

//Does the same as above, but with a title
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray;

@end