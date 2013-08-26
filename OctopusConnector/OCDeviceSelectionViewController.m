//
//  OCDeviceSelectionViewController.m
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/25/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import "OCDeviceSelectionViewController.h"

#define TAB_AVATAR     1
#define TAB_NEUROSKY   2
#define TAB_DEMODEVICE 3

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

- (void)viewWillAppear {
    NSTabViewItem *selectedItem = [tabView selectedTabViewItem];
    [self tabView:tabView didSelectTabViewItem:selectedItem];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    switch ([[tabViewItem identifier] intValue]) {
        case TAB_AVATAR:
            [self selectedAvatarPanel];
            break;
        case TAB_NEUROSKY:
            [self selectedNeuroskyPanel];
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
}

- (void)selectedNeuroskyPanel {
    [self listPossiblePortsWithPrefix:@"tty.BrainBand"];
}

- (void)selectedDemoDevicePanel {
    
}

- (NSArray *)listPossiblePortsWithPrefix:(NSString*)prefix {
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSArray *dirContents = [fm contentsOfDirectoryAtPath:@"/dev" error:nil];
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
    
//    NSMutableString *predicate = [NSMutableString stringWithString:@"self BEGINSWITH 'tty."];
//    [predicate appendString:prefix];
//    [predicate appendString:@"'"];
//    
//    NSPredicate *fltr = [NSPredicate predicateWithFormat:predicate];
//    NSArray *ports = [dirContents filteredArrayUsingPredicate:fltr];
    NSLog(@"%@", results);
    return results;
}

@end
