//
//  OCDeviceSelectionViewController.h
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"

@interface OCDeviceSelectionViewController : NSViewController<MASPreferencesViewController, NSTableViewDelegate> {
    IBOutlet NSTabView *tabView;
    IBOutlet NSComboBox *avatarPortComboBox;
}

@end
