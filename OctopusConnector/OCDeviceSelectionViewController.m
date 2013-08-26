//
//  OCDeviceSelectionViewController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCDeviceSelectionViewController.h"

@interface OCDeviceSelectionViewController ()

@end

@implementation OCDeviceSelectionViewController

- (id)init
{
    id viewController = [super initWithNibName:@"OCDeviceSelectionView" bundle:nil];
    return viewController;
}

- (NSString *)identifier
{
    return @"DevicePreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSApp applicationIconImage];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"Devices", @"Toolbar name for the devices preferences pane");
}


@end
