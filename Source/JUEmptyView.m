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

@synthesize title = _title;
@synthesize titleFont = _titleFont;
@synthesize titleColor = _titleColor;
@synthesize backgroundColor = _backgroundColor;
@synthesize forceShow = _forceShow;

#pragma mark -
#pragma mark Setter

- (void)setTitle:(NSString *)ttitle
{
    [_title autorelease];
    _title = [ttitle copy];
    
    [self setNeedsDisplay:YES];
}

- (void)setTitleFont:(NSFont *)ttitleFont
{
    [_titleFont autorelease];
    _titleFont = [ttitleFont retain];
    
    [self setNeedsDisplay:YES];
}

- (void)setTitleColor:(NSColor *)ttitleColor
{
    [_titleColor autorelease];
    _titleColor = [ttitleColor retain];
    
    [self setNeedsDisplay:YES];
}

- (void)setBackgroundColor:(NSColor *)tbackgroundColor
{
    [_backgroundColor autorelease];
    _backgroundColor = [tbackgroundColor retain];
    
     [self setNeedsDisplay:YES];
}

- (void)setForceShow:(BOOL)tforceShow
{
    _forceShow = tforceShow;
    
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma Drawing

- (void)drawRect:(NSRect)dirtyRect {
    if (forceShow || (self.subviews.count == 0)) {
		
		// Makes sure that drawing is needed
		if ((self.title.length > 0) && (self.titleColor != nil) && (self.titleFont != nil) && (self.backgroundColor != nil)) {
			
			// Configure caption style
			NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
			style.lineBreakMode = NSLineBreakByWordWrapping;
			style.alignment = NSTextAlignmentCenter;
			NSDictionary *fontColorMultilineAttributes = @{ NSForegroundColorAttributeName: self.titleColor, NSFontAttributeName: self.titleFont, NSParagraphStyleAttributeName: style };
			[style release];
			
			// Inset centered caption from bounds
			CGFloat const HorizontalInset = 20.0;
			CGFloat const VerticalInset = 10.0;
			NSEdgeInsets contentInsets = NSEdgeInsetsMake(HorizontalInset, HorizontalInset, VerticalInset, VerticalInset);
			
			// Draw multiline title using current settings
			NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:self.title attributes:fontColorMultilineAttributes];
			[self drawAttributedCaption:attributedTitle inBounds:self.bounds withInsets:contentInsets radius:8.0 usingFillColor:self.backgroundColor];
			[attributedTitle release];
		}
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
    [_title release];
    [_titleFont release];
    [_titleColor release];
    [_backgroundColor release];
    
    [super dealloc];
}

#pragma mark - Private API

- (void)drawAttributedCaption:(NSAttributedString *)caption inBounds:(NSRect)bounds withInsets:(NSEdgeInsets)insets radius:(double)radius usingFillColor:(NSColor *)fillColor {

	// Inset caption title
	CGSize captionSize = bounds.size;
	if (!NSEdgeInsetsEqual(insets, NSEdgeInsetsZero)) {
		captionSize.width -= (insets.left + insets.right);
		captionSize.height -= (insets.top + insets.bottom);
	}

	// Calculated centered area for text
	NSRect captionRect = NSIntegralRect([caption boundingRectWithSize:captionSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading]);
	captionRect.origin.x = (CGRectGetMidX(bounds) - CGRectGetWidth(captionRect) / 2.0);
	captionRect.origin.y = (CGRectGetMidY(bounds) - CGRectGetHeight(captionRect) / 2.0);

	// Calculate required area for background
	CGRect fillRect = captionRect;
	if (!NSEdgeInsetsEqual(insets, NSEdgeInsetsZero)) {
		fillRect.origin.x -= insets.left;
		fillRect.origin.y -= insets.top;
		fillRect.size.width += insets.left + insets.right;
		fillRect.size.height += insets.top + insets.bottom;
	}

	// Draw background and text if needed
	[fillColor setFill];
	[NSBezierPath bezierPathWithRoundedRect:fillRect xRadius:radius yRadius:radius];
	[caption drawInRect:captionRect];
}

@end
