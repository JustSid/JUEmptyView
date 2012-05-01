//
//  AppDelegate.m
//  JUEmptyView
//
//  Created by Sidney Just on 01.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)addView:(id)sender
{
    [emptyView addSubview:customView];
}

- (IBAction)removeView:(id)sender
{
    [customView removeFromSuperview];
}

@end
