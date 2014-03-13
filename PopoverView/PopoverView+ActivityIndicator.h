//
// Created by Jindrich Dolezy on 13.03.14.
//

#import <Foundation/Foundation.h>
#import "PopoverView.h"

@interface PopoverView (ActivityIndicator)

@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;


#pragma mark - Activity Indicator Methods

//Shows the activity indicator, and changes the title (if the title is available, and is a UILabel).
- (void)showActivityIndicatorWithMessage:(NSString *)msg;

//Hides the activity indicator, and changes the title (if the title is available) to the msg
- (void)hideActivityIndicatorWithMessage:(NSString *)msg;

@end