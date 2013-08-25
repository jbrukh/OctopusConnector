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
    return [super initWithNibName:@"OCRepositorySelectionView" bundle:nil];
}


#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"General", @"Toolbar item name for the General preference pane");
}


@end
