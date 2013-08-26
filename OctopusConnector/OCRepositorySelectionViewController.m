//
//  OCRepositorySelectionViewController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCRepositorySelectionViewController.h"
#import "Constants.h"

@interface OCRepositorySelectionViewController ()

@end

@implementation OCRepositorySelectionViewController

- (id)init
{
    id viewController = [super initWithNibName:@"OCRepositorySelectionView" bundle:nil];
    [viewController ensureRepoDir];
    return viewController;
}


#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"RepositoryPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameFolder];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"Repository", @"Toolbar name for the repository preferences pane");
}

- (void)viewDidDisappear {
    [self ensureRepoDir];
}

- (void)ensureRepoDir
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *repo = [defaults valueForKey:KEY_OCTOPUS__REPO];
    if ([repo length] <= 0) {
        NSMutableString *defaultDir = [NSMutableString stringWithString:NSHomeDirectory()];
        [defaultDir appendString:@"/.octopus"];
        [defaults setValue:defaultDir forKey:KEY_OCTOPUS__REPO];
    }
}

-(IBAction)openFileSelection:(id)sender{
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    if ([openDlg runModal] == NSOKButton)
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSURL* dir = [openDlg directoryURL];
        [repoPath setStringValue:[dir relativePath]];
    }
}



@end
