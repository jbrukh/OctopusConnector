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

@implementation OCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:statusMenu];
    [self setStatusItemUp];
}

- (void)setStatusItemUp {
    [statusItem setImage:[NSImage imageNamed:@"icon_up.png"]];
}

- (void)setStatusItemDown {
    [statusItem setImage:[NSImage imageNamed:@"icon_down.png"]];
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
}

#pragma mark -

NSString *const kFocusedAdvancedControlIndex = @"FocusedAdvancedControlIndex";

- (NSInteger)focusedAdvancedControlIndex
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kFocusedAdvancedControlIndex];
}

- (void)setFocusedAdvancedControlIndex:(NSInteger)focusedAdvancedControlIndex
{
    [[NSUserDefaults standardUserDefaults] setInteger:focusedAdvancedControlIndex forKey:kFocusedAdvancedControlIndex];
}


@end
