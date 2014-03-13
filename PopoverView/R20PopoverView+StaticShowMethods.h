//
// Created by Jindrich Dolezy on 13.03.14.
//

#import <Foundation/Foundation.h>
#import "R20PopoverView.h"

@interface R20PopoverView (StaticShowMethods)

#pragma mark - Class Static Showing Methods

//These are the main static methods you can use to display the popover.
//Simply call [R20PopoverView show...] with your arguments, and the popover will be generated, added to the view stack, and notify you when it's done.

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate;

+ (R20PopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id <PopoverViewDelegate>)delegate;

@end