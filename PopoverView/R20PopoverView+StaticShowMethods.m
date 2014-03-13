//
// Created by Jindrich Dolezy on 13.03.14.
//

#import "R20PopoverView+StaticShowMethods.h"
#import "R20PopoverView+ShowMethods.h"

@implementation R20PopoverView (StaticShowMethods)

#pragma mark - Static Methods

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withText:text];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withTitle:title withText:text];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withViewArray:viewArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withTitle:title withViewArray:viewArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withStringArray:stringArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withTitle:title withStringArray:stringArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withStringArray:stringArray withImageArray:imageArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withTitle:title withStringArray:stringArray withImageArray:imageArray];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withTitle:title withContentView:cView];
    return popoverView;
}

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate {
    R20PopoverView *popoverView = [[R20PopoverView alloc] initWithFrame:CGRectZero delegate:delegate];
    [popoverView showAtPoint:point inView:view withContentView:cView];
    return popoverView;
}

@end