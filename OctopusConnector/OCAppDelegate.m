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
#import "OCConsoleWindowController.h"

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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleConsoleOutputNotification:) name:OCConsoleOutputNotification object:nil];
    [center addObserver:self selector:@selector(handlePreferencesWillCloseNotification:) name:OCPreferencesWillCloseNotification object:nil];
    
    // ensure there are default settings
    [self ensureDefaults];
    
    // initialize the console, order matters!
    consoleController = [[OCConsoleWindowController alloc] init];
    // this will force the textView to be available for
    // input behind the scenes (it gets deserialized)
    [consoleController.window awakeFromNib];
    
    // version
    NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    NSString *fullVersion = [@"Mac Release " stringByAppendingFormat:@"%@\n\n", version];
    [consoleController appendConsole:fullVersion];
    aboutWindowController = [[OCAboutWindowController alloc] initWithWindowNibName:@"OCAboutWindow"];

    
    // initialize the process controller
    processController = [[OCProcessController alloc] init];
    if ([self validateDefaults]) {
        [processController startServer];
    }
}

- (void)ensureDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // by default, demo device
    NSString *device = [defaults valueForKey:OCKeyDevice];
    if ([device length] <= 0) {
        [defaults setValue:OCDeviceNameDemoDevice forKey:OCKeyDevice];
    }
    
    // by default, home directory repo
    NSString *repo = [defaults valueForKey:OCKeyRepo];
    if ([repo length] <= 0) {
        NSMutableString *defaultDir = [NSMutableString stringWithString:NSHomeDirectory()];
        [defaultDir appendString:@"/.octopus"];
        [defaults setValue:defaultDir forKey:OCKeyRepo];
    }
    
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

- (IBAction)toggleConsole:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [consoleController.window makeKeyWindow];
    [consoleController.window setIsVisible:YES];
    [consoleController.window setOrderedIndex:0];
}

- (IBAction)openAboutWindow:(id)sender  {
    [NSApp activateIgnoringOtherApps:YES];
    [aboutWindowController.window makeKeyWindow];
    [aboutWindowController.window setIsVisible:YES];
    [aboutWindowController.window setOrderedIndex:0];
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
    NSString *data = [notification object];
    [consoleController appendConsole:data];
}

- (void)handlePreferencesWillCloseNotification:(NSNotification *)notification {
    if ([self validateDefaults]) {
        [processController stopServer];
        [processController startServer];
    }
}

-(BOOL)validateDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *device = [defaults stringForKey:OCKeyDevice];
    NSString *repo = [defaults stringForKey:OCKeyRepo];
    
    if ([device length] <= 0 || [repo length] <= 0) {
        // device or repo is not set
        NSAlert *alert = [NSAlert alertWithMessageText:OCAppName defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You must select a device and a repository directory."];
        [alert runModal];
        
        return false;
    }
    
    if ([device isEqualToString:OCDeviceNameAvatar] && [[defaults stringForKey:OCKeyPortAvatar] length] <= 0) {
        NSAlert *alert = [NSAlert alertWithMessageText:OCAppName defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You must set a port for the Avatar EEG."];
        [alert runModal];

        return false;
    }
    
    if ([device isEqualToString:OCDeviceNameThinkgear] && [[defaults stringForKey:OCKeyPortThinkgear] length] <= 0) {
        NSAlert *alert = [NSAlert alertWithMessageText:OCAppName defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You must set a port for the ThinkGear device."];
        [alert runModal];

        return false;
    }
    return true;
}

@end
