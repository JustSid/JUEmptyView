//
//  AppDelegate.h
//  JUEmptyView
//
//  Created by Sidney Just on 01.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
@private
    IBOutlet NSWindow *window;
    IBOutlet NSView *customView;
    IBOutlet NSView *emptyView;
}

- (IBAction)addView:(id)sender;
- (IBAction)removeView:(id)sender;

@end
