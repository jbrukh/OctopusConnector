//
//  OCRepositorySelectionViewController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCRepositorySelectionViewController.h"

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
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"Repository", @"Toolbar name for the repository preferences pane");
}

- (void)ensureRepoDir
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *repo = [defaults valueForKey:@"octopusRepo"];
    if ([repo length] <= 0) {
        [defaults setValue:@"poop" forKey:@"octopusRepo"];
    }
}


@end
