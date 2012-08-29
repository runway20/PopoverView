//
//  PopoverView.h
//  Embark
//
//  Created by Oliver Rickard on 20/08/2012.
//
//

#import <UIKit/UIKit.h>

@class PopoverView;

@protocol PopoverViewDelegate <NSObject>

@optional

//Delegate receives this call as soon as the item has been selected
- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index;

//Delegate receives this call once the popover has begun the dismissal animation
- (void)popoverViewDidDismiss:(PopoverView *)popoverView;

@end

@interface PopoverView : UIView {
    CGRect boxFrame;
    CGSize contentSize;
    CGPoint arrowPoint;
    
    BOOL above;
    
    id<PopoverViewDelegate> delegate;
    
    NSArray *subviewsArray;
    
    NSArray *dividerRects;
    
    UIView *contentView;
    
    UIView *titleView;
    
    UIActivityIndicatorView *activityIndicator;
    
    //Instance variable that can change at runtime
    BOOL showDividerRects;
}

@property (nonatomic, retain) UIView *titleView;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) NSArray *subviewsArray;

@property (nonatomic, assign) id<PopoverViewDelegate> delegate;

#pragma mark - Class Static Showing Methods

//These are the main static methods you can use to display the popover.
//Simply call [PopoverView show...] with your arguments, and the popover will be generated, added to the view stack, and notify you when it's done.

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text delegate:(id<PopoverViewDelegate>)delegate;

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id<PopoverViewDelegate>)delegate;

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id<PopoverViewDelegate>)delegate;

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id<PopoverViewDelegate>)delegate;

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id<PopoverViewDelegate>)delegate;

+ (void)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id<PopoverViewDelegate>)delegate;

#pragma mark - Instance Showing Methods

//Adds/animates in the popover to the top of the view stack with the arrow pointing at the "point"
//within the specified view.  The contentView will be added to the popover, and should have either
//a clear color backgroundColor, or perhaps a rounded corner bg rect (radius 4.f if you're going to
//round).
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)contentView;

//Calls above method with a UILabel containing the text you deliver to this method.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text;

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

#pragma mark - Dismissal
//Dismisses the view, and removes it from the view stack.
- (void)dismiss;

#pragma mark - Activity Indicator Methods

//Shows the activity indicator, and changes the title (if the title is available, and is a UILabel).
- (void)showActivityIndicatorWithMessage:(NSString *)msg;

//Hides the activity indicator, and changes the title (if the title is available) to the msg
- (void)hideActivityIndicatorWithMessage:(NSString *)msg;

#pragma mark - Custom Image Showing

//Animate in, and display the image provided here.
- (void)showImage:(UIImage *)image withMessage:(NSString *)msg;

#pragma mark - Error/Success Methods

//Shows (and animates in) an error X in the contentView
- (void)showError;

//Shows (and animates in) a success checkmark in the contentView
- (void)showSuccess;

@end
