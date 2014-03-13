//
// Created by Jindrich Dolezy on 13.03.14.
//

#import "R20PopoverView+ShowImage.h"


@implementation R20PopoverView (ShowImage)

#pragma mark - Custom Image Showing

- (void)showImage:(UIImage *)image withMessage:(NSString *)msg duration:(NSTimeInterval)duration {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.alpha = 0.f;
    imageView.frame = CGRectMake(floorf(CGRectGetMidX(self.contentView.bounds) - image.size.width * 0.5f), floorf(CGRectGetMidY(self.contentView.bounds) - image.size.height * 0.5f + ((self.titleView) ? 20 : 0.f)), image.size.width, image.size.height);
    imageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);

    [self.contentView addSubview:imageView];

    [self hideAllSubviewsWithDuration:duration];

    if (msg) {
        [self setTitleViewText:msg];
    }

    [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.alpha = 1.f;
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)showImage:(UIImage *)image withMessage:(NSString *)msg {
    [self showImage:image withMessage:msg duration:0.2f];
}

#pragma mark - Error/Success Methods

- (void)showSuccess {
    [self showImage:[UIImage imageNamed:@"success"] withMessage:nil duration:0.1f];
}

- (void)showError {
    [self showImage:[UIImage imageNamed:@"error"] withMessage:nil duration:0.1f];
}


@end