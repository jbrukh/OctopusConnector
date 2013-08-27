//
//  OCAppDelegate.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCAppDelegate.h"
#import "MASPreferencesWindowController.h"
#import "OCRepositorySelectionViewController.h"
#import "OCDeviceSelectionViewController.h"
#import "Constants.h"

@implementation OCAppDelegate

#pragma mark - Initialization

- (void)awakeFromNib {
    // initialize the status bar icon
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:statusMenu];
    [self setStatusItemUp];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // subscribe to console data notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleConsoleOutputNotification:) name:OCConsoleOutputNotification object:nil];
    // initialize the process controller
    processController = [[OCProcessController alloc] init];
    [processController startServer];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [processController stopServer];
}

#pragma mark - Public accessors

- (NSWindowController *)preferencesWindowController
{
    if (_preferencesWindowController == nil)
    {
        // alloc the view controllers for preferences
        NSViewController *deviceSelectionView = [[OCDeviceSelectionViewController alloc] init];
        NSViewController *repositorySelectionView = [[OCRepositorySelectionViewController alloc] init];
        NSArray *controllers = [[NSArray alloc] initWithObjects:deviceSelectionView, repositorySelectionView, nil];
        
        // create the preferences window controller
        NSString *title = NSLocalizedString(@"Octopus Connector Preferences", @"Common title for preferences window");
        _preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
    }
    return _preferencesWindowController;
}

#pragma mark - Actions

- (IBAction)openPreferences:(id)sender
{
    [self.preferencesWindowController showWindow:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)openWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:OCOctopusWebsite]];
}

#pragma mark - Methods

- (void)setStatusItemUp {
    [statusItem setImage:[NSImage imageNamed:@"icon_up.png"]];
}

- (void)setStatusItemDown {
    [statusItem setImage:[NSImage imageNamed:@"icon_down.png"]];
}

#pragma mark - OCConsoleOutputNotification

- (void)handleConsoleOutputNotification:(NSNotification *)notification
{
    // TODO: write to console
    NSString *data = [notification object];
    NSLog(@"### %@", data);
}

@end
