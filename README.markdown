#PopoverView#

PopoverView is a simple resolution-independent UIView written entirely in CoreGraphics and QuartzCore for display of modal content on both iPhone and iPad.  It can display singular UIView contentViews, arrays of `UIViews`, display titles, or even allow selection from a list of strings.  It is implemented via a very simple static interface that allows you to show the popover with just a single line.  All animation, positioning, and memory allocations are handled by the component at runtime.  We are releasing under the MIT License.

For More Information, please see our full blog post:
[PopoverView](http://www.getosito.com/blog/engineering/popoverview-a-flexible-modal-content-view-for-ios/)

***

<img src="http://www.getosito.com/img/postImages/popoverMap.png" width="320" height="480" />

***

##Demonstration##
As a quick demonstration, I used a UIView from another one of my components called OCCalendar[^1].  To display this to the user on tap, I simply allocate and initialize the view, then I use a single line to display it to the user.    The PopoverView handles positioning above/below the point of interest, handles all of the memory management, and manages the view stack so it gets displayed to the user at the correct location.

``` objc
OCDaysView *daysView = [[OCDaysView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
[daysView setMonth:10];
[daysView setYear:2012];
//[PopoverView showPopoverAtRect:rect inView:self.view withContentView:[daysView autorelease] delegate:self];
[PopoverView showPopoverAtRect:rect inView:self.view withTitle:@"October 2012" withContentView:[daysView autorelease] delegate:self];
```

As you may note, I have two versions of the display code here.  One of them displays the `daysView` as a single `contentView` with no title, and the other displays the same view with a "October 2012" title.

<img src="http://www.getosito.com/img/postImages/popoverCal1.png" width="320" height="480" />

***

##Demo Project##
The structure of the demo project is very simple.  The PopoverView.h and .m files are in the "PopoverView" folder in the root directory.  The demo project files are in the "popover/demo" subdirectory.

***

##License##

(MIT Licensed)

Copyright (c) 2012 Runway 20 Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
