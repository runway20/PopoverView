//
// Created by Jindrich Dolezy on 11.03.14.
//

#import "PopoverView+ShowMethods.h"


@implementation PopoverView (ShowMethods)

#pragma mark - Static Methods

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withText:text];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withTitle:title withText:text];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withViewArray:viewArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withTitle:title withViewArray:viewArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withStringArray:stringArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withTitle:title withStringArray:stringArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withStringArray:stringArray withImageArray:imageArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withTitle:title withStringArray:stringArray withImageArray:imageArray];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withTitle:title withContentView:cView];
    popoverView.delegate = delegate;
    return popoverView;
}

+ (PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate {
    PopoverView *popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    [popoverView showAtPoint:point inView:view withContentView:cView];
    popoverView.delegate = delegate;
    return popoverView;
}

#pragma mark - instance show methods

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text {
    UIFont *font = self.textFont;

    CGSize screenSize = [self screenSize];
    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(screenSize.width - self.horizontalMargin * 4.f, 1000.f) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    textView.backgroundColor = [UIColor clearColor];
    textView.userInteractionEnabled = NO;
    [textView setNumberOfLines:0]; //This is so the label word wraps instead of cutting off the text
    textView.font = font;
    textView.textAlignment = self.textAlignment;
    textView.textColor = self.textColor;
    textView.text = text;

    [self showAtPoint:point inView:view withViewArray:@[textView]];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text {
    UIFont *font = self.textFont;

    CGSize screenSize = [self screenSize];
    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(screenSize.width - self.horizontalMargin * 4.f, 1000.f) lineBreakMode:NSLineBreakByWordWrapping];

    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    textView.backgroundColor = [UIColor clearColor];
    textView.userInteractionEnabled = NO;
    [textView setNumberOfLines:0]; //This is so the label word wraps instead of cutting off the text
    textView.font = font;
    textView.textAlignment = self.textAlignment;
    textView.textColor = self.textColor;
    textView.text = text;

    [self showAtPoint:point inView:view withTitle:title withViewArray:@[textView]];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray {
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];

    float totalHeight = 0.f;
    float totalWidth = 0.f;

    int i = 0;

    //Position each view the first time, and identify which view has the largest width that controls
    //the sizing of the popover.
    for (UIView *view in viewArray) {

        view.frame = CGRectMake(0, totalHeight, view.frame.size.width, view.frame.size.height);
        //Only add padding below the view if it's not the last item
        float padding = (i == viewArray.count - 1) ? 0 : self.boxPadding;

        totalHeight += view.frame.size.height + padding;

        if (view.frame.size.width > totalWidth) {
            totalWidth = view.frame.size.width;
        }

        [container addSubview:view];

        i++;
    }

    //If dividers are enabled, then we allocate the divider rect array.  This will hold NSValues
    if (self.showDividersBetweenViews) {
        dividerRects = [[NSMutableArray alloc] initWithCapacity:viewArray.count - 1];
    }

    container.frame = CGRectMake(0, 0, totalWidth, totalHeight);

    i = 0;

    totalHeight = 0;

    //Now we actually change the frame element for each subview, and center the views horizontally.
    for (UIView *view in viewArray) {
        if ([view autoresizingMask] == UIViewAutoresizingFlexibleWidth) {
            //Now make sure all flexible views are the full width
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, totalWidth, view.frame.size.height);
        } else {
            //If the view is not flexible width, then we position it centered in the view
            //without stretching it.
            view.frame = CGRectMake(floorf(CGRectGetMinX(boxFrame) + totalWidth * 0.5f - view.frame.size.width * 0.5f), view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }

        //and if dividers are enabled, we record their position for the drawing methods
        if (self.showDividersBetweenViews && i != viewArray.count - 1) {
            CGRect dividerRect = CGRectMake(view.frame.origin.x, floorf(view.frame.origin.y + view.frame.size.height + self.boxPadding * 0.5f), view.frame.size.width, 0.5f);

            [((NSMutableArray *) dividerRects) addObject:[NSValue valueWithCGRect:dividerRect]];
        }

        //Only add padding below the view if it's not the last item
        float padding = (i == viewArray.count - 1) ? 0.f : self.boxPadding;

        totalHeight += view.frame.size.height + padding;

        i++;
    }

    self.subviewsArray = viewArray;

    [self showAtPoint:point inView:view withContentView:container];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray {
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];

    //Create a label for the title text.
    CGSize titleSize = [title sizeWithFont:self.titleFont];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, titleSize.width, titleSize.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = self.titleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = self.titleColor;
    titleLabel.text = title;

    //Make sure that the title's label will have non-zero height.  If it has zero height, then we don't allocate any space
    //for it in the positioning of the views.
    float titleHeightOffset = (titleSize.height > 0.f ? self.boxPadding : 0.f);

    float totalHeight = titleSize.height + titleHeightOffset + self.boxPadding;
    float totalWidth = titleSize.width;

    int i = 0;

    //Position each view the first time, and identify which view has the largest width that controls
    //the sizing of the popover.
    for (UIView *view in viewArray) {

        view.frame = CGRectMake(0, totalHeight, view.frame.size.width, view.frame.size.height);

        //Only add padding below the view if it's not the last item.
        float padding = (i == viewArray.count - 1) ? 0.f : self.boxPadding;

        totalHeight += view.frame.size.height + padding;

        if (view.frame.size.width > totalWidth) {
            totalWidth = view.frame.size.width;
        }

        [container addSubview:view];

        i++;
    }

    //If dividers are enabled, then we allocate the divider rect array.  This will hold NSValues
    if (self.showDividersBetweenViews) {
        dividerRects = [[NSMutableArray alloc] initWithCapacity:viewArray.count - 1];
    }

    i = 0;

    for (UIView *view in viewArray) {
        if ([view autoresizingMask] == UIViewAutoresizingFlexibleWidth) {
            //Now make sure all flexible views are the full width
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, totalWidth, view.frame.size.height);
        } else {
            //If the view is not flexible width, then we position it centered in the view
            //without stretching it.
            view.frame = CGRectMake(floorf(CGRectGetMinX(boxFrame) + totalWidth * 0.5f - view.frame.size.width * 0.5f), view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }

        //and if dividers are enabled, we record their position for the drawing methods
        if (self.showDividersBetweenViews && i != viewArray.count - 1) {
            CGRect dividerRect = CGRectMake(view.frame.origin.x, floorf(view.frame.origin.y + view.frame.size.height + self.boxPadding * 0.5f), view.frame.size.width, 0.5f);

            [((NSMutableArray *) dividerRects) addObject:[NSValue valueWithCGRect:dividerRect]];
        }

        i++;
    }

    titleLabel.frame = CGRectMake(floorf(totalWidth * 0.5f - titleSize.width * 0.5f), 0, titleSize.width, titleSize.height);

    //Store the titleView as an instance variable if it is larger than 0 height (not an empty string)
    if (titleSize.height > 0) {
        self.titleView = titleLabel;
    }

    [container addSubview:titleLabel];

    container.frame = CGRectMake(0, 0, totalWidth, totalHeight);

    self.subviewsArray = viewArray;

    [self showAtPoint:point inView:view withContentView:container];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray {
    NSMutableArray *labelArray = [[NSMutableArray alloc] initWithCapacity:stringArray.count];

    UIFont *font = self.textFont;

    for (NSString *string in stringArray) {
        CGSize textSize = [string sizeWithFont:font];
        UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        textButton.backgroundColor = [UIColor clearColor];
        textButton.titleLabel.font = font;
        textButton.titleLabel.textAlignment = self.textAlignment;
        textButton.titleLabel.textColor = self.textColor;
        [textButton setTitle:string forState:UIControlStateNormal];
        textButton.layer.cornerRadius = 4.f;
        [textButton setTitleColor:self.textColor forState:UIControlStateNormal];
        [textButton setTitleColor:self.textHighlightColor forState:UIControlStateHighlighted];
        [textButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];

        [labelArray addObject:textButton];
    }

    [self showAtPoint:point inView:view withViewArray:labelArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray {
    NSMutableArray *labelArray = [[NSMutableArray alloc] initWithCapacity:stringArray.count];

    UIFont *font = self.textFont;

    for (NSString *string in stringArray) {
        CGSize textSize = [string sizeWithFont:font];
        UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        textButton.backgroundColor = [UIColor clearColor];
        textButton.titleLabel.font = font;
        textButton.titleLabel.textAlignment = self.textAlignment;
        textButton.titleLabel.textColor = self.textColor;
        [textButton setTitle:string forState:UIControlStateNormal];
        textButton.layer.cornerRadius = 4.f;
        [textButton setTitleColor:self.textColor forState:UIControlStateNormal];
        [textButton setTitleColor:self.textHighlightColor forState:UIControlStateHighlighted];
        [textButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];

        [labelArray addObject:textButton];
    }

    [self showAtPoint:point inView:view withTitle:title withViewArray:labelArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray {
    //Here we do something pretty similar to the stringArray method above.
    //We create an array of subviews that contains the strings and images centered above a label.

    NSAssert((stringArray.count == imageArray.count), @"stringArray.count should equal imageArray.count");
    NSMutableArray *tempViewArray = [self makeTempViewsWithStrings:stringArray andImages:imageArray];

    [self showAtPoint:point inView:view withViewArray:tempViewArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray {
    NSAssert((stringArray.count == imageArray.count), @"stringArray.count should equal imageArray.count");
    NSMutableArray *tempViewArray = [self makeTempViewsWithStrings:stringArray andImages:imageArray];

    [self showAtPoint:point inView:view withTitle:title withViewArray:tempViewArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView {
    [self showAtPoint:point inView:view withTitle:title withViewArray:[NSArray arrayWithObject:cView]];
}

#pragma mark - helpers

// get the screen size, adjusted for orientation and status bar display
// see http://stackoverflow.com/questions/7905432/how-to-get-orientation-dependent-height-and-width-of-the-screen/7905540#7905540
- (CGSize)screenSize {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO) {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}

- (NSMutableArray *)makeTempViewsWithStrings:(NSArray *)stringArray andImages:(NSArray *)imageArray {
    NSMutableArray *tempViewArray = [[NSMutableArray alloc] initWithCapacity:stringArray.count];

    UIFont *font = self.textFont;

    for (int i = 0; i < stringArray.count; i++) {
        NSString *string = [stringArray objectAtIndex:i];

        //First we build a label for the text to set in.
        CGSize textSize = [string sizeWithFont:font];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.textAlignment = self.textAlignment;
        label.textColor = self.textColor;
        label.text = string;
        label.layer.cornerRadius = 4.f;

        //Now we grab the image at the same index in the imageArray, and create
        //a UIImageView for it.
        UIImage *image = [imageArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

        //Take the larger of the two widths as the width for the container
        float containerWidth = MAX(imageView.frame.size.width, label.frame.size.width);
        float containerHeight = label.frame.size.height + self.imageTopPadding + self.imageBottomPadding + imageView.frame.size.height;

        //This container will hold both the image and the label
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];

        //Now we do the frame manipulations to put the imageView on top of the label, both centered
        imageView.frame = CGRectMake(floorf(containerWidth * 0.5f - imageView.frame.size.width * 0.5f), self.imageTopPadding, imageView.frame.size.width, imageView.frame.size.height);
        label.frame = CGRectMake(floorf(containerWidth * 0.5f - label.frame.size.width * 0.5f), imageView.frame.size.height + self.imageBottomPadding + self.imageTopPadding, label.frame.size.width, label.frame.size.height);

        [containerView addSubview:imageView];
        [containerView addSubview:label];


        [tempViewArray addObject:containerView];
    }

    return tempViewArray;
}

@end