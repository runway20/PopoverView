//
//  R20PopoverView.h
//  Embark
//
//  Created by Oliver Rickard on 20/08/2012.
//
//

#import <UIKit/UIKit.h>


@class R20PopoverView;

@protocol PopoverViewDelegate <NSObject>

@optional

//Delegate receives this call as soon as the item has been selected
- (void)popoverView:(R20PopoverView *)popoverView didSelectItemAtIndex:(NSUInteger)index;

//Delegate receives this call once the popover has finished the dismissal animation
- (void)popoverViewDidDismiss:(R20PopoverView *)popoverView;

//Delegate receives this call once the popover has begun the dismissal animation
- (void)popoverViewWillDismiss:(R20PopoverView *)popoverView;

@end


@interface R20PopoverView : UIView

@property (nonatomic, readonly, strong) UIView *topView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *subviewsArray;

@property (nonatomic, readonly) CGRect popoverFrame;
@property (nonatomic, readonly) CGPoint arrowPoint;
@property (nonatomic, readonly) BOOL arrowAbove;

@property (nonatomic, strong) NSArray *dividerRects;

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

//Alpha value for the shadow behind the R20PopoverView
@property (nonatomic) CGFloat shadowAlpha UI_APPEARANCE_SELECTOR;

//Blur for the shadow behind the R20PopoverView
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
// hack - if we want to use appearance we must use NSUInteger instead of BOOL
@property (nonatomic) NSUInteger showDividersBetweenViews UI_APPEARANCE_SELECTOR;

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

@property (nonatomic, strong) UIColor *titleSeparatorColor UI_APPEARANCE_SELECTOR;


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


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PopoverViewDelegate>)delegate;

#pragma mark - Instance Showing Methods

// This is kinda hacky solution for UIAppearance to work properly. Problem is that appearance properties are set only
// after adding this view to superview. But we are using them in show methods, so we need to add this to superview
// first in order to get right values. This method is called first in all other show methods.
// If you are not using appearance you can safely ignore this.
- (void)prepareForAppearance;

//Adds/animates in the popover to the top of the view stack with the arrow pointing at the "point"
//within the specified view.  The contentView will be added to the popover, and should have either
//a clear color backgroundColor, or perhaps a rounded corner bg rect (radius 4.f if you're going to
//round).
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)contentView;

//Lays out the R20PopoverView at a point once all of the views have already been setup elsewhere
- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view;

//Lays out the R20PopoverView at a point once all of the views have already been setup elsewhere with
//specified animation duration
- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration;

#pragma mark - Other Interaction

// Hides all subviews and separators in popover with animation of specified duration
- (void)hideAllSubviewsWithDuration:(NSTimeInterval)duration;

// If title view is label, set specified message as its text
- (void)setTitleViewText:(NSString *)msg;


#pragma mark - Dismissal
//Dismisses the view, and removes it from the view stack.
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

@end
