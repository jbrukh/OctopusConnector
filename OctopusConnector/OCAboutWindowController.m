//
//  OCAboutWindowController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/27/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCAboutWindowController.h"

@interface OCAboutWindowController ()

@end

@implementation OCAboutWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
     NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    [self.title setStringValue:[@"Octopus Connector " stringByAppendingString:version]];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
