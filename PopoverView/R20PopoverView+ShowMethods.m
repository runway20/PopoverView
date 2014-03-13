//
// Created by Jindrich Dolezy on 11.03.14.
//

#import "R20PopoverView+ShowMethods.h"


@implementation R20PopoverView (ShowMethods)

#pragma mark - instance show methods

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

- (void)showAtPoint:(CGPoint)point inView:(UIView *)parentView withTitle:(NSString *)title withViewArray:(NSArray *)viewArray {
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];

    UILabel *titleLabel = nil;
    CGSize titleSize = CGSizeZero;
    if (title) {
        //Create a label for the title text.
        titleSize = [title sizeWithFont:self.titleFont];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, titleSize.width, titleSize.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = self.titleFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = self.titleColor;
        titleLabel.text = title;
    }

    //Make sure that the title's label will have non-zero height.  If it has zero height, then we don't allocate any space
    //for it in the positioning of the views.
    __block CGFloat totalHeight = titleSize.height + (titleSize.height > 0.f ? self.boxPadding * 2 : 0.f);
    __block CGFloat totalWidth = titleSize.width;

    //Position each view the first time, and identify which view has the largest width that controls
    //the sizing of the popover.
    [viewArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.frame = CGRectMake(0, totalHeight, view.frame.size.width, view.frame.size.height);

        //Only add padding below the view if it's not the last item.
        totalHeight += view.frame.size.height + ((i == viewArray.count - 1) ? 0.f : self.boxPadding);

        if (view.frame.size.width > totalWidth) {
            totalWidth = view.frame.size.width;
        }

        [container addSubview:view];
    }];

    //If dividers are enabled, then we allocate the divider rect array.  This will hold NSValues
    NSMutableArray *dividerRects = nil;
    if (self.showDividersBetweenViews) {
        dividerRects = [[NSMutableArray alloc] initWithCapacity:viewArray.count - 1];
    }

    [viewArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        if ([view autoresizingMask] == UIViewAutoresizingFlexibleWidth) {
            //Now make sure all flexible views are the full width
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, totalWidth, view.frame.size.height);
        } else {
            //If the view is not flexible width, then we position it centered in the view
            //without stretching it.
            view.frame = CGRectMake(floorf(CGRectGetMinX(self.popoverFrame) + totalWidth * 0.5f - view.frame.size.width * 0.5f), view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        }

        //and if dividers are enabled, we record their position for the drawing methods
        if (self.showDividersBetweenViews && i != viewArray.count - 1) {
            CGRect dividerRect = CGRectMake(view.frame.origin.x, floorf(view.frame.origin.y + view.frame.size.height + self.boxPadding * 0.5f), view.frame.size.width, 0.5f);

            [dividerRects addObject:[NSValue valueWithCGRect:dividerRect]];
        }
    }];

    if (titleLabel) {
        self.titleView = titleLabel;
        titleLabel.frame = CGRectMake(floorf(totalWidth * 0.5f - titleSize.width * 0.5f), 0, titleSize.width, titleSize.height);
        [container addSubview:titleLabel];
    }
    container.frame = CGRectMake(0, 0, totalWidth, totalHeight);

    self.dividerRects = dividerRects;
    self.subviewsArray = viewArray;

    [self showAtPoint:point inView:parentView withContentView:container];
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

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray {
    NSAssert((stringArray.count == imageArray.count), @"stringArray.count should equal imageArray.count");

    NSMutableArray *tempViewArray = [[NSMutableArray alloc] initWithCapacity:stringArray.count];

    UIFont *font = self.textFont;

    [stringArray enumerateObjectsUsingBlock:^(NSString *string, NSUInteger i, BOOL *stop) {

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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray[i]];

        //Take the larger of the two widths as the width for the container
        CGFloat containerWidth = MAX(imageView.frame.size.width, label.frame.size.width);
        CGFloat containerHeight = label.frame.size.height + self.imageTopPadding + self.imageBottomPadding + imageView.frame.size.height;

        //This container will hold both the image and the label
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];

        //Now we do the frame manipulations to put the imageView on top of the label, both centered
        imageView.frame = CGRectMake(floorf(containerWidth * 0.5f - imageView.frame.size.width * 0.5f), self.imageTopPadding, imageView.frame.size.width, imageView.frame.size.height);
        label.frame = CGRectMake(floorf(containerWidth * 0.5f - label.frame.size.width * 0.5f), imageView.frame.size.height + self.imageBottomPadding + self.imageTopPadding, label.frame.size.width, label.frame.size.height);

        [containerView addSubview:imageView];
        [containerView addSubview:label];


        [tempViewArray addObject:containerView];
    }];

    [self showAtPoint:point inView:view withTitle:title withViewArray:tempViewArray];
}

// content view and title

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text {
    [self showAtPoint:point inView:view withTitle:nil withText:text];
}

// no title variants - just passing nil for title

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView {
    [self showAtPoint:point inView:view withTitle:title withViewArray:@[cView]];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray {
    [self showAtPoint:point inView:view withTitle:nil withViewArray:viewArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray {
    [self showAtPoint:point inView:view withTitle:nil withStringArray:stringArray];
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray {
    [self showAtPoint:point inView:view withTitle:nil withStringArray:stringArray withImageArray:imageArray];
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


@end