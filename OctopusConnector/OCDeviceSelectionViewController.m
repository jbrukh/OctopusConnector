//
//  OCDeviceSelectionViewController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCDeviceSelectionViewController.h"
#import "Constants.h"

#define TAB_AVATAR      0
#define TAB_THINKGEAR   1
#define TAB_DEMODEVICE  2

@interface OCDeviceSelectionViewController ()

@end

@implementation OCDeviceSelectionViewController

- (id)init
{
    id viewController = [super initWithNibName:@"OCDeviceSelectionView" bundle:nil];
    defaults = [NSUserDefaults standardUserDefaults];
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

- (void)awakeFromNib {
    NSLog(@"blah %@", [defaults objectForKey:OCKeySelectedDeviceMenuIndex]);
    if ([defaults objectForKey:OCKeySelectedDeviceMenuIndex] == NULL) {
        [deviceSelectionPopupButton selectItemAtIndex:TAB_DEMODEVICE];
        [tabView selectTabViewItemAtIndex:TAB_DEMODEVICE];
    }
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    switch ([[tabViewItem identifier] intValue]) {
        case TAB_AVATAR:
            [self selectedAvatarPanel];
            break;
        case TAB_THINKGEAR:
            [self selectedThinkGearPanel];
            break;
        case TAB_DEMODEVICE:
            [self selectedDemoDevicePanel];
            break;
        default:
            break;
    }
}

- (void)selectedAvatarPanel {
    NSArray *ports = [self listPossiblePortsWithPrefix:@"tty.Avatar"];
    [avatarPortComboBox removeAllItems];
    [avatarPortComboBox addItemsWithObjectValues:ports];
    [self ensureComboSelected:avatarPortComboBox withUserDefault:OCKeyPortAvatar];
    
}

- (void)selectedThinkGearPanel {
    NSArray *ports = [self listPossiblePortsWithPrefix:@"tty.BrainBand"];
    [neuroskyPortComboBox removeAllItems];
    [neuroskyPortComboBox addItemsWithObjectValues:ports];
    [self ensureComboSelected:neuroskyPortComboBox withUserDefault:OCKeyPortThinkgear];
}

- (void)ensureComboSelected:(NSComboBox *)comboBox withUserDefault:(NSString *)key {
    if ([defaults objectForKey:key] == NULL && [comboBox indexOfSelectedItem] < 0 && [comboBox numberOfItems] > 0) {
        [comboBox selectItemAtIndex:0];
    }
}

- (void)selectedDemoDevicePanel {
    
}

- (IBAction)selectDeviceTab:(id)sender
{
    [tabView selectTabViewItemAtIndex:[deviceSelectionPopupButton indexOfSelectedItem]];
}

- (NSArray *)listPossiblePortsWithPrefix:(NSString*)prefix {
    NSString *root = @"/dev";
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:root];
    NSString *file;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    while ((file = [dirEnum nextObject]) != nil) {
        // check if it starts with path
        if ([file hasPrefix:prefix]) {
            [results addObject:[root stringByAppendingPathComponent:file]];
        }
    }
    
    return results;
}

@end
