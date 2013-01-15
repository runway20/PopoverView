//
//  PopoverView_Configuration.h
//  popover
//
//  Created by Bas Pellis on 12/25/12.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#pragma mark Constants - Configure look/feel

// BOX GEOMETRY

//Height/width of the actual arrow
#define kArrowHeight 12.f

//padding within the box for the contentView
#define kBoxPadding 10.f

//control point offset for rounding corners of the main popover box
#define kCPOffset 1.8f

//radius for the rounded corners of the main popover box
#define kBoxRadius 4.f

//Curvature value for the arrow.  Set to 0.f to make it linear.
#define kArrowCurvature 0.f

//Minimum distance from the side of the arrow to the beginning of curvature for the box
#define kArrowHorizontalPadding 3.f

//Alpha value for the shadow behind the PopoverView
#define kShadowAlpha 0.6f

//Blur for the shadow behind the PopoverView
#define kShadowBlur 5.f;

//Box gradient bg alpha
#define kBoxAlpha 0.95f

//Padding along top of screen to allow for any nav/status bars
#define kTopMargin 50.f

//margin along the left and right of the box
#define kHorizontalMargin 5.f

//padding along top of icons/images
#define kImageTopPadding 3.f

//padding along bottom of icons/images
#define kImageBottomPadding 3.f


// DIVIDERS BETWEEN VIEWS

//Bool that turns off/on the dividers
#define kShowDividersBetweenViews YES

//color for the divider fill
#define kDividerColor [UIColor colorWithWhite:0.8f alpha:0.15f]


// BACKGROUND GRADIENT

//bottom color white in gradient bg
#define kGradientBottomColor [UIColor colorWithRed:0.09f green:0.09f blue:0.09f alpha:kBoxAlpha]

//top color white value in gradient bg
#define kGradientTopColor [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:kBoxAlpha]


// TITLE GRADIENT

//bool that turns off/on title gradient
#define kDrawTitleGradient YES

//bottom color white value in title gradient bg
#define kGradientTitleBottomColor [UIColor colorWithWhite:0.2 alpha:kBoxAlpha]

//top color white value in title gradient bg
#define kGradientTitleTopColor [UIColor colorWithWhite:0.4 alpha:kBoxAlpha]


// FONTS

//normal text font
#define kTextFont [UIFont fontWithName:@"HelveticaNeue" size:12.f]

//normal text color
#define kTextColor [UIColor colorWithWhite:0.8 alpha:1]
// highlighted text color
#define kTextHighlightColor [UIColor colorWithWhite:1.0f alpha:1.000]

//normal text alignment
#define kTextAlignment UITextAlignmentLeft

//title font
#define kTitleFont [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.f]

//title text color
#define kTitleColor [UIColor colorWithRed:0.329 green:0.341 blue:0.353 alpha:1]
