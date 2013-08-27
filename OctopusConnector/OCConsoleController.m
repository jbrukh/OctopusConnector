//
//  OCConsoleController.m
//  OctopusStatusBar
//
//  Created by Jake Brukhman on 5/26/13.
//  Copyright (c) 2013 Octopus. All rights reserved.
//

#import "OCConsoleController.h"

@interface OCConsoleController ()

@end

@implementation OCConsoleController

- (id)init
{
    self = [super initWithWindowNibName:@"OCConsole"];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [textView setEditable:NO];
    [textView setSelectable:YES];
    [textView setFont:[NSFont fontWithName:@"Andale Mono" size:11]];
    [textView setTextColor:colorFromRGB(100,149,237)];
    [textView setBackgroundColor:colorFromRGB(100, 100, 100)];
}

/*
 Show the console.
 */
-(void) show {
    [NSApp activateIgnoringOtherApps:YES];
    [[self window] setIsVisible:YES];
}

/*
 Hide the console.
 */
-(void) hide {
    [[self window] setIsVisible:NO];
}

-(BOOL) isVisible {
    return [[self window] isVisible];
}

/*
 Append data to the console.
 */
- (void)appendConsole:(NSString *)str{
    NSString *full;
    full = [[textView string] stringByAppendingString:str];
    [textView setString:full];
    NSRange theEnd=NSMakeRange([full length],0);
    [textView scrollRangeToVisible:theEnd];
}

/*
 Helper method to specify colors in RGB.
 */
static NSColor *colorFromRGB(unsigned char r, unsigned char g, unsigned char b)
{
    return [NSColor colorWithCalibratedRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0];
}

@end

