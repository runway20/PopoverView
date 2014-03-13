//
// Created by Jindrich Dolezy on 13.03.14.
//

#import "R20PopoverView+ActivityIndicator.h"


@implementation R20PopoverView (ActivityIndicator)

#pragma mark - Activity Indicator

//Animates in a progress indicator, and removes
- (void)showActivityIndicatorWithMessage:(NSString *)msg {
    [self setTitleViewText:msg];

    [self hideAllSubviewsWithDuration:0.2f];

    [self.activityIndicator removeFromSuperview];

    // self.activityIndicator is weak, so we have to store it in the strong variable before adding to superview
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    ai.frame = CGRectMake(CGRectGetMidX(self.contentView.bounds) - 10.f, CGRectGetMidY(self.contentView.bounds) - 10.f + 20.f, 20.f, 20.f);
    [self.contentView addSubview:ai];

    [ai startAnimating];

    self.activityIndicator = ai;
}

- (void)hideActivityIndicatorWithMessage:(NSString *)msg {
    [self setTitleViewText:msg];

    [self.activityIndicator stopAnimating];
    [UIView animateWithDuration:0.1f animations:^{
        self.activityIndicator.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.activityIndicator removeFromSuperview];
    }];
}

@end