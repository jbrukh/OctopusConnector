//
//  OCConsoleWindowController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/26/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCConsoleWindowController.h"

@interface OCConsoleWindowController ()

@end

@implementation OCConsoleWindowController
@synthesize textView;

- (id)init
{
    self = [super initWithWindowNibName:@"OCConsoleWindow"];
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
