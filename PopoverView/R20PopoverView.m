//
//  R20PopoverView.m
//  Embark
//
//  Created by Oliver Rickard on 20/08/2012.
//
//

#import "R20PopoverView.h"
#import "R20PopoverView_Configuration.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - Implementation

@implementation R20PopoverView {
    //Instance variable that can change at runtime
    BOOL showDividerRects;
}


#pragma mark - View Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame delegate:nil];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PopoverViewDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        _delegate = delegate;

        // Initialization code
        self.backgroundColor = [UIColor clearColor];

        [self setPropertiesFromConfiguration];

        showDividerRects = YES;
    }
    return self;
}

- (void)setPropertiesFromConfiguration {
    // default values are set directly into ivars to allow UIAppearance selectors to work;
    _arrowHeight = kArrowHeight;
    _boxPadding = kBoxPadding;
    _CPOffset = kCPOffset;
    _boxRadius = kBoxRadius;
    _arrowCurvature = kArrowCurvature;
    _arrowHorizontalPadding = kArrowHorizontalPadding;
    _shadowAlpha = kShadowAlpha;
    _shadowBlur = kShadowBlur;
    _boxAlpha = kBoxAlpha;
    _topMargin = kTopMargin;
    _horizontalMargin = kHorizontalMargin;
    _imageTopPadding = kImageTopPadding;
    _imageBottomPadding = kImageBottomPadding;
    _showArrow = YES;
    _showDividersBetweenViews = kShowDividersBetweenViews;
    _dividerColor = kDividerColor;
    _gradientBottomColor = kGradientBottomColor;
    _gradientTopColor = kGradientTopColor;
    _drawTitleGradient = kDrawTitleGradient;
    _gradientTitleBottomColor = kGradientTitleBottomColor;
    _gradientTitleTopColor = kGradientTitleTopColor;
    _titleSeparatorColor = kTitleSeparatorColor;
    _textFont = kTextFont;
    _textColor = kTextColor;
    _textHighlightColor = kTextHighlightColor;
    _textAlignment = kTextAlignment;
    _titleFont = kTitleFont;
    _titleColor = kTitleColor;
    _drawBorder = kDrawBorder;
    _borderColor = kBorderColor;
    _borderWidth = kBorderWidth;
}

#pragma mark - Display methods

- (void)showAtPoint:(CGPoint)point inView:(UIView *)parentView withContentView:(UIView *)contentView {
    self.contentView = contentView;

    // get the top view
    // http://stackoverflow.com/questions/3843411/getting-reference-to-the-top-most-view-window-in-ios-application/8045804#8045804
    _topView = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];

    [self setupLayout:point inView:parentView];

    // Make the view small and transparent before animation
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);

    // animate into full size
    // First stage animates to 1.05x normal size, then second stage animates back down to 1x size.
    // This two-stage animation creates a little "pop" on open.
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view {
    [self layoutAtPoint:point inView:view duration:0.2f];
}

- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration {
    // make transparent
    self.alpha = 0.f;

    [self setupLayout:point inView:view]; // TODO do not call setupLayout twice!

    // animate back to full opacity
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
    } completion:nil];
}

- (void)setupLayout:(CGPoint)point inView:(UIView *)view {
    CGPoint topPoint = [self.topView convertPoint:point fromView:view];
    CGRect topViewBounds = self.topView.bounds;

    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    CGFloat contentWidth = CGRectGetWidth(self.contentView.frame);

    CGFloat padding = self.boxPadding;

    CGFloat boxHeight = contentHeight + 2.f * padding;
    CGFloat boxWidth = contentWidth + 2.f * padding;


    //Make sure the arrow point is within the drawable bounds for the popover.
    _arrowPoint = topPoint;
    if (_arrowPoint.x + self.arrowHeight > topViewBounds.size.width - self.horizontalMargin - self.boxRadius - self.arrowHorizontalPadding) {//Too far to the right
        //Correcting Arrow Point because it's too far to the right
        _arrowPoint.x = topViewBounds.size.width - self.horizontalMargin - self.boxRadius - self.arrowHorizontalPadding - self.arrowHeight;
    } else if (_arrowPoint.x - self.arrowHeight < self.horizontalMargin + self.boxRadius + self.arrowHorizontalPadding) {//Too far to the left
        //Correcting Arrow Point because it's too far to the left
        _arrowPoint.x = self.horizontalMargin + self.arrowHeight + self.boxRadius + self.arrowHorizontalPadding;
    }


    //Check to see if the centered xOrigin value puts the box outside of the normal range.
    CGFloat xOrigin = floorf(self.arrowPoint.x - boxWidth * 0.5f);
    if (xOrigin < CGRectGetMinX(topViewBounds) + self.horizontalMargin) {
        xOrigin = CGRectGetMinX(topViewBounds) + self.horizontalMargin;
    } else if (xOrigin + boxWidth > CGRectGetMaxX(topViewBounds) - self.horizontalMargin) {
        //Check to see if the positioning puts the box out of the window towards the left
        xOrigin = CGRectGetMaxX(topViewBounds) - self.horizontalMargin - boxWidth;
    }


    // Check if arrow should be shown above or below the popover
    CGFloat arrowHeight = self.showArrow ? self.arrowHeight : 0;
    CGFloat topPadding = self.topMargin;
    if (topPoint.y - contentHeight - arrowHeight - topPadding < CGRectGetMinY(topViewBounds)) {
        //Position below because it won't fit above.
        _arrowAbove = NO;
        _popoverFrame = CGRectMake(xOrigin, self.arrowPoint.y + arrowHeight, boxWidth, boxHeight);
    } else {
        //Position above.
        _arrowAbove = YES;
        _popoverFrame = CGRectMake(xOrigin, self.arrowPoint.y - arrowHeight - boxHeight, boxWidth, boxHeight);
    }


    // Calculate content view position
    self.contentView.frame = CGRectMake(self.popoverFrame.origin.x + padding, self.popoverFrame.origin.y + padding, contentWidth, contentHeight);


    //We set the anchorPoint here so the popover will "grow" out of the arrowPoint specified by the user.
    //You have to set the anchorPoint before setting the frame, because the anchorPoint property will
    //implicitly set the frame for the view, which we do not want.
    self.layer.anchorPoint = CGPointMake(self.arrowPoint.x / topViewBounds.size.width, self.arrowPoint.y / topViewBounds.size.height);
    self.frame = topViewBounds;
    [self setNeedsDisplay];

    [self addSubview:self.contentView];
    [self.topView addSubview:self];


    //Add a tap gesture recognizer to the large invisible view (self), which will detect taps anywhere on the screen.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.cancelsTouchesInView = NO; // Allow touches through to a UITableView or other touchable view, as suggested by Dimajp.
    [self addGestureRecognizer:tap];

    self.userInteractionEnabled = YES;
}

- (void)hideAllSubviewsWithDuration:(NSTimeInterval)duration {
    if (self.subviewsArray.count > 0) { // TODO : get rid of subviews array?
        [UIView animateWithDuration:duration animations:^{
            for (UIView *view in self.subviewsArray) {
                view.alpha = 0.f;
            }
        }];

        if (showDividerRects) { // TODO : rename this property
            showDividerRects = NO;
            [self setNeedsDisplay];
        }
    }
}

- (void)setTitleViewText:(NSString *)msg {
    if ([self.titleView isKindOfClass:[UILabel class]]) {
        ((UILabel *) self.titleView).text = msg;
    }
}

#pragma mark - User Interaction

- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.contentView];
    __block BOOL found = NO;

    [self.subviewsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        if (CGRectContainsPoint(view.frame, point)) {
            //The tap was within this view, so we notify the delegate, and break the loop.

            *stop = found = YES;
            if ([view isKindOfClass:[UIButton class]]) {
                return;
            }
            if ([self.delegate respondsToSelector:@selector(popoverView:didSelectItemAtIndex:)]) {
                [self.delegate popoverView:self didSelectItemAtIndex:i];
            }
        }
    }];

    if (!found && CGRectContainsPoint(self.contentView.bounds, point)) {
        // Tap is inside popover
        found = YES;
    }

    if (!found) {
        [self dismiss:YES];
    }
}

- (void)didTapButton:(UIButton *)sender {
    NSUInteger index = [self.subviewsArray indexOfObject:sender];

    if (index != NSNotFound && [self.delegate respondsToSelector:@selector(popoverView:didSelectItemAtIndex:)]) {
        [self.delegate popoverView:self didSelectItemAtIndex:index];
    }
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    if (!animated) {
        [self dismissComplete];
    }
    else {
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.1f;
            self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        } completion:^(BOOL finished) {
            [self dismissComplete];
        }];
    }
}

- (void)dismissComplete {
    [self removeFromSuperview];

    if ([self.delegate respondsToSelector:@selector(popoverViewDidDismiss:)]) {
        [self.delegate popoverViewDidDismiss:self];
    }
}

#pragma mark - Drawing Routines

- (UIBezierPath *)createPopoverPathFromFrame:(CGRect)frame radius:(CGFloat)radius cpOffset:(CGFloat)cpOffset {
    // Build the popover path
    /*
     LT2            RT1
     LT1⌜⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⎺⌝RT2
     |               |
     |    popover    |
     |               |
     LB2⌞_______________⌟RB1
     LB1           RB2

     Traverse rectangle in clockwise order, starting at LT1
     L = Left
     R = Right
     T = Top
     B = Bottom
     1,2 = order of traversal for any given corner

     */

    CGFloat xMin = CGRectGetMinX(frame);
    CGFloat yMin = CGRectGetMinY(frame);

    CGFloat xMax = CGRectGetMaxX(frame);
    CGFloat yMax = CGRectGetMaxY(frame);

    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin + radius)];//LT1
    [popoverPath addCurveToPoint:CGPointMake(xMin + radius, yMin) controlPoint1:CGPointMake(xMin, yMin + radius - cpOffset) controlPoint2:CGPointMake(xMin + radius - cpOffset, yMin)];//LT2

    //If the popover is positioned below (!above) the arrowPoint, then we know that the arrow must be on the top of the popover.
    //In this case, the arrow is located between LT2 and RT1
    if (self.showArrow && !self.arrowAbove) {
        [popoverPath addLineToPoint:CGPointMake(self.arrowPoint.x - self.arrowHeight, yMin)];//left side
        [popoverPath addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x - self.arrowHeight + self.arrowCurvature, yMin) controlPoint2:self.arrowPoint];//actual arrow point
        [popoverPath addCurveToPoint:CGPointMake(self.arrowPoint.x + self.arrowHeight, yMin) controlPoint1:self.arrowPoint controlPoint2:CGPointMake(self.arrowPoint.x + self.arrowHeight - self.arrowCurvature, yMin)];//right side
    }

    [popoverPath addLineToPoint:CGPointMake(xMax - radius, yMin)];//RT1
    [popoverPath addCurveToPoint:CGPointMake(xMax, yMin + radius) controlPoint1:CGPointMake(xMax - radius + cpOffset, yMin) controlPoint2:CGPointMake(xMax, yMin + radius - cpOffset)];//RT2
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax - radius)];//RB1
    [popoverPath addCurveToPoint:CGPointMake(xMax - radius, yMax) controlPoint1:CGPointMake(xMax, yMax - radius + cpOffset) controlPoint2:CGPointMake(xMax - radius + cpOffset, yMax)];//RB2

    //If the popover is positioned above the arrowPoint, then we know that the arrow must be on the bottom of the popover.
    //In this case, the arrow is located somewhere between LB1 and RB2
    if (self.showArrow && self.arrowAbove) {
        [popoverPath addLineToPoint:CGPointMake(self.arrowPoint.x + self.arrowHeight, yMax)];//right side
        [popoverPath addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x + self.arrowHeight - self.arrowCurvature, yMax) controlPoint2:self.arrowPoint];//arrow point
        [popoverPath addCurveToPoint:CGPointMake(self.arrowPoint.x - self.arrowHeight, yMax) controlPoint1:self.arrowPoint controlPoint2:CGPointMake(self.arrowPoint.x - self.arrowHeight + self.arrowCurvature, yMax)];
    }

    [popoverPath addLineToPoint:CGPointMake(xMin + radius, yMax)];//LB1
    [popoverPath addCurveToPoint:CGPointMake(xMin, yMax - radius) controlPoint1:CGPointMake(xMin + radius - cpOffset, yMax) controlPoint2:CGPointMake(xMin, yMax - radius + cpOffset)];//LB2
    [popoverPath closePath];
    return popoverPath;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect frame = self.popoverFrame;
    CGFloat radius = self.boxRadius; //Radius of the curvature.
    CGFloat cpOffset = self.CPOffset; //Control Point Offset.  Modifies how "curved" the corners are.

    UIBezierPath *popoverPath = [self createPopoverPathFromFrame:frame radius:radius cpOffset:cpOffset];
    [self drawBackgroundAtFrame:frame popoverPath:popoverPath];

    //Draw the title background
    if (self.drawTitleGradient) {
        [self drawTitleGradientAtRect:frame radius:radius cpOffset:cpOffset];
    }

    //Draw the divider rects if we need to
    if (self.showDividersBetweenViews && showDividerRects) {
        [self drawDividerRects];
    }

    //Draw border if we need to
    //The border is done last because it needs to be drawn on top of everything else
    if (self.drawBorder) {
        [self.borderColor setStroke];
        popoverPath.lineWidth = self.borderWidth;
        [popoverPath stroke];
    }

}

- (void)drawBackgroundAtFrame:(CGRect)frame popoverPath:(UIBezierPath *)popoverPath {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Shadow Declarations
    UIColor *shadow = [UIColor colorWithWhite:0.0f alpha:self.shadowAlpha];
    CGSize shadowOffset = CGSizeMake(0, 1);
    CGFloat shadowBlurRadius = self.shadowBlur;

    //// Gradient Declarations
    NSArray *gradientColors = [NSArray arrayWithObjects:
            (id) self.gradientTopColor.CGColor,
            (id) self.gradientBottomColor.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, gradientLocations);


    //These floats are the top and bottom offsets for the gradient drawing so the drawing includes the arrows.
    CGFloat bottomOffset = (self.showArrow && self.arrowAbove ? self.arrowHeight : 0.f);
    CGFloat topOffset = (self.showArrow && !self.arrowAbove ? self.arrowHeight : 0.f);

    //Draw the actual gradient and shadow.
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [popoverPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(frame), CGRectGetMinY(frame) - topOffset), CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame) + bottomOffset), 0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)drawTitleGradientAtRect:(CGRect)frame radius:(CGFloat)radius cpOffset:(CGFloat)cpOffset {
    CGFloat xMin = CGRectGetMinX(frame);
    CGFloat yMin = CGRectGetMinY(frame);

    CGFloat xMax = CGRectGetMaxX(frame);

    //Calculate the height of the title bg
    CGFloat titleBGHeight = -1;

    if (self.titleView != nil) {
        titleBGHeight = self.boxPadding * 2.f + self.titleView.frame.size.height;
    }


    //Draw the title bg height, but only if we need to.
    if (titleBGHeight > 0.f) {
        CGPoint startingPoint = CGPointMake(xMin, yMin + titleBGHeight);
        CGPoint endingPoint = CGPointMake(xMax, yMin + titleBGHeight);

        UIBezierPath *titleBGPath = [UIBezierPath bezierPath];
        [titleBGPath moveToPoint:startingPoint];
        [titleBGPath addLineToPoint:CGPointMake(xMin, yMin + radius)];//LT1
        [titleBGPath addCurveToPoint:CGPointMake(xMin + radius, yMin) controlPoint1:CGPointMake(xMin, yMin + radius - cpOffset) controlPoint2:CGPointMake(xMin + radius - cpOffset, yMin)];//LT2

        //If the popover is positioned below (!above) the arrowPoint, then we know that the arrow must be on the top of the popover.
        //In this case, the arrow is located between LT2 and RT1
        if (self.showArrow && !self.arrowAbove) {
            [titleBGPath addLineToPoint:CGPointMake(self.arrowPoint.x - self.arrowHeight, yMin)];//left side
            [titleBGPath addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x - self.arrowHeight + self.arrowCurvature, yMin) controlPoint2:self.arrowPoint];//actual arrow point
            [titleBGPath addCurveToPoint:CGPointMake(self.arrowPoint.x + self.arrowHeight, yMin) controlPoint1:self.arrowPoint controlPoint2:CGPointMake(self.arrowPoint.x + self.arrowHeight - self.arrowCurvature, yMin)];//right side
        }

        [titleBGPath addLineToPoint:CGPointMake(xMax - radius, yMin)];//RT1
        [titleBGPath addCurveToPoint:CGPointMake(xMax, yMin + radius) controlPoint1:CGPointMake(xMax - radius + cpOffset, yMin) controlPoint2:CGPointMake(xMax, yMin + radius - cpOffset)];//RT2
        [titleBGPath addLineToPoint:endingPoint];
        [titleBGPath addLineToPoint:startingPoint];
        [titleBGPath closePath];

        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();

        //// Gradient Declarations
        NSArray *gradientColors = [NSArray arrayWithObjects:
                (id) self.gradientTitleTopColor.CGColor,
                (id) self.gradientTitleBottomColor.CGColor, nil];
        CGFloat gradientLocations[] = {0, 1};
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, gradientLocations);


        //These floats are the top and bottom offsets for the gradient drawing so the drawing includes the arrows.
        CGFloat topOffset = (self.showArrow && !self.arrowAbove ? self.arrowHeight : 0.f);

        //Draw the actual gradient and shadow.
        CGContextSaveGState(context);
        CGContextBeginTransparencyLayer(context, NULL);
        [titleBGPath addClip];
        CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMidX(frame), yMin - topOffset), CGPointMake(CGRectGetMidX(frame), yMin + titleBGHeight), 0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);

        UIBezierPath *dividerLine = [UIBezierPath bezierPathWithRect:CGRectMake(startingPoint.x, startingPoint.y, (endingPoint.x - startingPoint.x), 0.5f)];
        [self.titleSeparatorColor setFill];
        [dividerLine fill];

        //// Cleanup
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorSpace);
    }
}

- (void)drawDividerRects {
    for (NSValue *value in self.dividerRects) {
        CGRect rect = value.CGRectValue;
        rect.origin.x += self.contentView.frame.origin.x;
        rect.origin.y += self.contentView.frame.origin.y;

        UIBezierPath *dividerPath = [UIBezierPath bezierPathWithRect:rect];
        [self.dividerColor setFill];
        [dividerPath fill];
    }
}

@end
