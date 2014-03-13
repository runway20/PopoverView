//
//  ViewController.m
//  popover
//
//  Created by Oliver Rickard on 21/08/2012.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
#import "PopoverView+ShowMethods.h"
#import "PopoverView+StaticShowMethods.h"
#import "PopoverView+ShowImage.h"
#import "OCDaysView.h"
#import <QuartzCore/QuartzCore.h> //This is just for the daysView where I call "daysView.layer" not necessary normally.

#define kStringArray @[@"YES", @"NO"]
#define kImageArray @[[UIImage imageNamed:@"success"], [UIImage imageNamed:@"error"]]

@interface ViewController () <PopoverViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *tapAnywhereLabel;
@property (nonatomic, strong) PopoverView *popoverView;

@end


@implementation ViewController

#pragma mark EXAMPLE CODE IS HERE

- (IBAction)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    //NSLog(@"tapped at %@", NSStringFromCGPoint(point));

    // Here are a couple of different options for how to display the Popover

    // PopoverView can be styled using appearance
    //[[PopoverView appearance] setGradientBottomColor:[UIColor redColor]];


//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                                withText:@"This is a very long popover box.  As you can see, it goes to multiple lines in size." delegate:self]; // Show text wrapping popover with long string

//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                               withTitle:@"This is a title"
//                                withText:@"This is text"
//                                delegate:self]; // Show text with title

//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                         withStringArray:kStringArray
//                                delegate:self]; // Show the string array defined at top of this file

    self.popoverView = [PopoverView showPopoverAtPoint:point
            inView:self.view
            withTitle:@"Was this helpful?"
            withStringArray:kStringArray
            delegate:self]; // Show string array defined at top of this file with title.

//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                         withStringArray:kStringArray
//                          withImageArray:kImageArray
//                                delegate:self];

//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                               withTitle:@"DEBUG"
//                         withStringArray:kStringArray
//                          withImageArray:kImageArray
//                                delegate:self];

//    // Here's a little bit more advanced sample.  I create a custom view, and hand it off to the PopoverView to display for me.  I round the corners
//    OCDaysView *daysView = [[OCDaysView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
//    [daysView setMonth:10];
//    [daysView setYear:2012];
//    daysView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f]; //Give it a background color
//    daysView.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.f].CGColor; //Add a border
//    daysView.layer.borderWidth = 0.5f; //One retina pixel width
//    daysView.layer.cornerRadius = 4.f;
//    daysView.layer.masksToBounds = YES;
//    
//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                         withContentView:[daysView autorelease]
//                                delegate:self]; // Show calendar with no title
//    pv = [PopoverView showPopoverAtPoint:point
//                                  inView:self.view
//                               withTitle:@"October 2012"
//                         withContentView:[daysView autorelease]
//                                delegate:self]; // Show calendar with title

//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    pv = [PopoverView showPopoverAtPoint:point
//                                   inView:self.view
//                          withContentView:tableView
//                                 delegate:self];
}

#pragma mark - DEMO - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"text";
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.f];

    return cell;
}

#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);

    // Figure out which string was selected, store in "string"
    NSString *string = kStringArray[index];

    // Show a success image, with the string from the array
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:string];

    // alternatively, you can use
    // [popoverView showSuccess];
    // or
    // [popoverView showError];

    // Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.popoverView = nil;
}

#pragma mark - UIViewController Methods

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // get new center coords
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));

    if (self.popoverView) {
        // popover is visible, so we need to either reposition or dismiss it (dismising is probably best to avoid confusion)
        BOOL dismiss = NO;
        if (dismiss) {
            [self.popoverView dismiss:NO];
        } else {
            // move popover
            [self.popoverView layoutAtPoint:center inView:self.view duration:duration];
        }
    }
}

@end
