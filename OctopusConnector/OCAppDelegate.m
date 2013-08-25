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

@implementation OCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

#pragma mark - Public accessors

- (NSWindowController *)preferencesWindowController
{
    if (_preferencesWindowController == nil)
    {
        // alloc the view controllers for preferences
        NSViewController *repositorySelectionView = [[OCRepositorySelectionViewController alloc] init];
        NSArray *controllers = [[NSArray alloc] initWithObjects:repositorySelectionView, nil];
        
        // create the preferences window controller
        NSString *title = NSLocalizedString(@"Octopus Connector Preferences", @"Common title for Preferences window");
        _preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
    }
    return _preferencesWindowController;
}


#pragma mark - Actions

- (IBAction)openPreferences:(id)sender
{
    [self.preferencesWindowController showWindow:sender];
}



@end
