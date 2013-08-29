//
//  OCDiagnosticsWindowController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/29/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCDiagnosticsWindowController.h"

@interface OCDiagnosticsWindowController ()

@end

@implementation OCDiagnosticsWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
