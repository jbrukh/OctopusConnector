//
//  OCAppDelegate.h
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OCProcessController.h"
#import "OCConsoleWindowController.h"
#import "OCAboutWindowController.h"
#import "OCDiagnosticsWindowController.h"

@interface OCAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindowController *_preferencesWindowController;
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
    OCProcessController *processController;
    OCConsoleWindowController *consoleController;
    OCAboutWindowController *aboutWindowController;
    OCDiagnosticsWindowController *diagnosticsWindowController;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, readonly) NSWindowController *preferencesWindowController;


- (void)setStatusItemUp;
- (void)setStatusItemDown;
- (IBAction)openPreferences:(id)sender;
- (IBAction)openWebsite:(id)sender;
- (IBAction)openContactUs:(id)sender;
- (IBAction)toggleConsole:(id)sender;
- (IBAction)openAboutWindow:(id)sender;
- (IBAction)restart:(id)sender;

@end
