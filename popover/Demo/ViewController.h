//
//  ViewController.h
//  popover
//
//  Created by Oliver Rickard on 21/08/2012.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "R20PopoverView.h"

@interface ViewController : UIViewController <R20PopoverViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    R20PopoverView *pv;
    
}

@end
