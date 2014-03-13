//
//  ViewController.m
//  popover
//
//  Created by Oliver Rickard on 21/08/2012.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#import <QuartzCore/QuartzCore.h> //This is just for the daysView where I call "daysView.layer" not necessary normally.
#import "ViewController.h"
#import "R20PopoverView.h"
#import "R20PopoverView+StaticShowMethods.h"
#import "R20PopoverView+ShowImage.h"
#import "OCDaysView.h"


#define kStringArray @[ \
    @"YES", \
    @"NO"]

#define kImageArray @[ \
    [UIImage imageNamed:@"success"], \
    [UIImage imageNamed:@"error"]]

// this must be in sync with createPopoverAtPoint: switch
#define kDemoOptions @[ \
    @"Long text", \
    @"Text with title", \
    @"String array", \
    @"String array with title", \
    @"String & image array", \
    @"String & image array with title", \
    @"Custom view", \
    @"Custom view with title", \
    @"Table view with title"]


@interface ViewController () <PopoverViewDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, weak) IBOutlet UILabel *tapAnywhereLabel;
@property(nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property(nonatomic, weak) IBOutlet UISwitch *dismissSwitch;

@property(nonatomic, strong) R20PopoverView *popoverView;

@end


@implementation ViewController

#pragma mark EXAMPLE CODE IS HERE

- (R20PopoverView *)createPopoverAtPoint:(CGPoint)point {
    // Here are a couple of different options for how to display the Popover

    // PopoverView can be styled using appearance
    //[[R20PopoverView appearance] setGradientBottomColor:[UIColor redColor]];

    switch ([self.pickerView selectedRowInComponent:0]) {
        default:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withText:@"This is a very long popover box.  As you can see, it goes to multiple lines in size."
                    delegate:self]; // Show text wrapping popover with long string

        case 1:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withTitle:@"This is a title"
                    withText:@"This is text"
                    delegate:self]; // Show text with title


        case 2:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withStringArray:kStringArray
                    delegate:self]; // Show the string array defined at top of this file
        case 3:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withTitle:@"Was this helpful?"
                    withStringArray:kStringArray
                    delegate:self]; // Show string array defined at top of this file with title.
        case 4:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withStringArray:kStringArray
                    withImageArray:kImageArray
                    delegate:self];

        case 5:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withTitle:@"This is a title"
                    withStringArray:kStringArray
                    withImageArray:kImageArray
                    delegate:self];

        case 6:
            // Here's a little bit more advanced sample.  I create a custom view, and hand it off to
            // the PopoverView to display for me.  I round the corners
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withContentView:[self createCustomView]
                    delegate:self]; // Show calendar with no title


        case 7:
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withTitle:@"October 2012"
                    withContentView:[self createCustomView]
                    delegate:self]; // Show calendar with title

        case 8: {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            return [R20PopoverView showPopoverAtPoint:point
                    inView:self.view
                    withContentView:tableView
                    delegate:self];
        }
    }
}


#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(R20PopoverView *)popoverView didSelectItemAtIndex:(NSUInteger)index {
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

- (void)popoverViewDidDismiss:(R20PopoverView *)popoverView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.popoverView = nil;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundView.backgroundColor = cell.backgroundColor = tableView.backgroundColor;
}


#pragma mark - UIViewController Methods

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // get new center coords
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));

    if (self.popoverView) {
        // popover is visible, so we need to either reposition or dismiss it (dismising is probably best to avoid confusion)
        if (self.dismissSwitch.on) {
            [self.popoverView dismiss:NO];
        } else {
            [self.popoverView layoutAtPoint:center inView:self.view duration:duration];
        }
    }
}


#pragma mark - Demo view handling

- (IBAction)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    self.popoverView = [self createPopoverAtPoint:point];
}

- (UIView *)createCustomView {
    OCDaysView *daysView = [[OCDaysView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    [daysView setMonth:10];
    [daysView setYear:2012];
    daysView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f]; //Give it a background color
    daysView.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.f].CGColor; //Add a border
    daysView.layer.borderWidth = 0.5f; //One retina pixel width
    daysView.layer.cornerRadius = 4.f;
    daysView.layer.masksToBounds = YES;
    return daysView;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return kDemoOptions[(NSUInteger) row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return kDemoOptions.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
