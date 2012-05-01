//
//  JUEmptyView.m
//  JUEmptyView
//
//  Copyright (c) 2012 by Sidney Just
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
//  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JUEmptyView.h"

@implementation JUEmptyView
@synthesize title, titleFont, titleColor, backgroundColor;
@synthesize forceShow;

#pragma mark -
#pragma mark Setter

- (void)setTitle:(NSString *)ttitle
{
    [title autorelease];
    title = [ttitle copy];
    
    [self setNeedsDisplay:YES];
}

- (void)setTitleFont:(NSFont *)ttitleFont
{
    [titleFont autorelease];
    titleFont = [ttitleFont retain];
    
    [self setNeedsDisplay:YES];
}

- (void)setTitleColor:(NSColor *)ttitleColor
{
    [titleColor autorelease];
    titleColor = [ttitleColor retain];
    
    [self setNeedsDisplay:YES];
}

- (void)setBackgroundColor:(NSColor *)tbackgroundColor
{
    [backgroundColor autorelease];
    backgroundColor = [tbackgroundColor retain];
    
     [self setNeedsDisplay:YES];
}

- (void)setForceShow:(BOOL)tforceShow
{
    forceShow = tforceShow;
    
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma Drawing

- (void)drawRect:(NSRect)dirtyRect
{
    if(forceShow || [[self subviews] count] == 0)
    {
        NSRect rect = [self bounds];
        NSSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:titleFont forKey:NSFontAttributeName]];
        NSSize bezierSize = NSMakeSize(size.width + 40.0, size.height + 20.0);
        NSRect drawRect;
        
        
        // Background
        drawRect = NSMakeRect(0.0, 0.0, bezierSize.width, bezierSize.height);
        drawRect.origin.x = round((rect.size.width * 0.5) - (bezierSize.width * 0.5));
        drawRect.origin.y = round((rect.size.height * 0.5) - (bezierSize.height * 0.5));
        
        [backgroundColor setFill];
        [[NSBezierPath bezierPathWithRoundedRect:drawRect xRadius:8.0 yRadius:8.0] fill];
        
        
        // String
        drawRect = NSMakeRect(0.0, 0.0, size.width, size.height);
        drawRect.origin.x = round((rect.size.width * 0.5) - (size.width * 0.5));
        drawRect.origin.y = round((rect.size.height * 0.5) - (size.height * 0.5));
        
        [title drawInRect:drawRect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleColor, NSForegroundColorAttributeName, 
                                                                                             titleFont, NSFontAttributeName, nil]];
    }
}


- (void)willRemoveSubview:(NSView *)subview
{
    [super willRemoveSubview:subview];
    [self setNeedsDisplay:YES];
}

- (void)didAddSubview:(NSView *)subview
{
    [super didAddSubview:subview];
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Constructor / Destructor

- (void)constructWithTitle:(NSString *)ttitle font:(NSFont *)font color:(NSColor *)color andBackgroundColor:(NSColor *)tbackgroundColor
{
    title = ttitle ? [ttitle copy] : [[NSString alloc] initWithString:@"Untitled"];
    titleFont = font ? [font retain] : [[NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]] retain];
    titleColor = color ? [color retain] : [[NSColor colorWithCalibratedRed:0.890 green:0.890 blue:0.890 alpha:1.0] retain];
    backgroundColor = tbackgroundColor ? [tbackgroundColor retain] : [[NSColor colorWithCalibratedRed:0.588 green:0.588 blue:0.588 alpha:1.000] retain];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super initWithCoder:decoder])
    {
        [self constructWithTitle:nil font:nil color:nil andBackgroundColor:nil];
    }
    
    return self;
}

- (id)initWithFrame:(NSRect)frameRect
{
    if(self = [super initWithFrame:frameRect])
    {
        [self constructWithTitle:nil font:nil color:nil andBackgroundColor:nil];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)ttitle
{
    if((self = [super init]))
    {
        [self constructWithTitle:ttitle font:nil color:nil andBackgroundColor:nil];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)ttitle andFont:(NSFont *)font
{
    if((self = [super init]))
    {
        [self constructWithTitle:ttitle font:font color:nil andBackgroundColor:nil];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)ttitle font:(NSFont *)font color:(NSColor *)color andBackgroundColor:(NSColor *)tbackgroundColor
{
    if((self = [super init]))
    {
        [self constructWithTitle:ttitle font:font color:color andBackgroundColor:tbackgroundColor];
    }
    
    return self;
}

- (void)dealloc
{
    [title release];
    [titleFont release];
    [titleColor release];
    [backgroundColor release];
    
    [super dealloc];
}

@end
