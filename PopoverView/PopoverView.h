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
    CGPoint arrowPoint;
    
    BOOL above;

    UIView *topView;

    NSArray *dividerRects;
    
    UIActivityIndicatorView *activityIndicator;
    
    //Instance variable that can change at runtime
    BOOL showDividerRects;
}

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *subviewsArray;

@property (nonatomic, weak) id<PopoverViewDelegate> delegate;

#pragma mark - Appearance

//Height/width of the actual arrow
@property (nonatomic) CGFloat arrowHeight UI_APPEARANCE_SELECTOR;

//padding within the box for the contentView
@property (nonatomic) CGFloat boxPadding UI_APPEARANCE_SELECTOR;

//control point offset for rounding corners of the main popover box
@property (nonatomic) CGFloat CPOffset UI_APPEARANCE_SELECTOR;

//radius for the rounded corners of the main popover box
@property (nonatomic) CGFloat boxRadius UI_APPEARANCE_SELECTOR;

//Curvature value for the arrow.  Set to 0.f to make it linear.
@property (nonatomic) CGFloat arrowCurvature UI_APPEARANCE_SELECTOR;

//Minimum distance from the side of the arrow to the beginning of curvature for the box
@property (nonatomic) CGFloat arrowHorizontalPadding UI_APPEARANCE_SELECTOR;

//Alpha value for the shadow behind the PopoverView
@property (nonatomic) CGFloat shadowAlpha UI_APPEARANCE_SELECTOR;

//Blur for the shadow behind the PopoverView
@property (nonatomic) CGFloat shadowBlur UI_APPEARANCE_SELECTOR;

//Box gradient bg alpha
@property (nonatomic) CGFloat boxAlpha UI_APPEARANCE_SELECTOR;

//Padding along top of screen to allow for any nav/status bars
@property (nonatomic) CGFloat topMargin UI_APPEARANCE_SELECTOR;

//margin along the left and right of the box
@property (nonatomic) CGFloat horizontalMargin UI_APPEARANCE_SELECTOR;

//padding along top of icons/images
@property (nonatomic) CGFloat imageTopPadding UI_APPEARANCE_SELECTOR;

//padding along bottom of icons/images
@property (nonatomic) CGFloat imageBottomPadding UI_APPEARANCE_SELECTOR;

// show popover arrow
@property (nonatomic) NSInteger showArrow UI_APPEARANCE_SELECTOR;

// DIVIDERS BETWEEN VIEWS

//Bool that turns off/on the dividers
@property (nonatomic) BOOL showDividersBetweenViews UI_APPEARANCE_SELECTOR;

//color for the divider fill
@property (nonatomic, strong) UIColor *dividerColor UI_APPEARANCE_SELECTOR;


// BACKGROUND GRADIENT

//bottom color white in gradient bg
@property (nonatomic, strong) UIColor *gradientBottomColor UI_APPEARANCE_SELECTOR;

//top color white value in gradient bg
@property (nonatomic, strong) UIColor *gradientTopColor UI_APPEARANCE_SELECTOR;


// TITLE GRADIENT

//bool that turns off/on title gradient
@property (nonatomic) NSInteger drawTitleGradient UI_APPEARANCE_SELECTOR;

//bottom color white value in title gradient bg
@property (nonatomic, strong) UIColor *gradientTitleBottomColor UI_APPEARANCE_SELECTOR;

//top color white value in title gradient bg
@property (nonatomic, strong) UIColor *gradientTitleTopColor UI_APPEARANCE_SELECTOR;


// FONTS

//normal text font
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

//normal text color
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

// highlighted text color
@property (nonatomic, strong) UIColor *textHighlightColor UI_APPEARANCE_SELECTOR;

//normal text alignment
@property (nonatomic) NSTextAlignment textAlignment UI_APPEARANCE_SELECTOR;

//title font
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;

//title text color
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;


// BORDER

//bool that turns off/on the border
@property (nonatomic) NSInteger drawBorder UI_APPEARANCE_SELECTOR;

//border color
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

//border width
@property (nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

#pragma mark - Instance Showing Methods

//Adds/animates in the popover to the top of the view stack with the arrow pointing at the "point"
//within the specified view.  The contentView will be added to the popover, and should have either
//a clear color backgroundColor, or perhaps a rounded corner bg rect (radius 4.f if you're going to
//round).
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)contentView;

//Lays out the PopoverView at a point once all of the views have already been setup elsewhere
- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view;

#pragma mark - Other Interaction
//This method animates the rotation of the PopoverView to a new point
- (void)animateRotationToNewPoint:(CGPoint)point inView:(UIView *)view withDuration:(NSTimeInterval)duration;

#pragma mark - Dismissal
//Dismisses the view, and removes it from the view stack.
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

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


#import "PopoverView+ShowMethods.h"
