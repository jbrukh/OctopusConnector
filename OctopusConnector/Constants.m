//
//  Constants.m
//  OctopusStatusBar
//
//  Created by Jake Brukhman on 5/26/13.
//  Copyright (c) 2013 Octopus. All rights reserved.
//

#include "Constants.h"

/* Constants */

NSString *const OCServerBinary                              = @"octopus";
NSString *const OCDemoDataFile                              = @"6cdc3b4a-2de7-04e0-7211-c6ae23117f1e";
NSString *const OCOctopusWebsite                            = @"http://www.octopusmetrics.com";
NSString *const OCOctopusContactUs                          = @"https://octopusmetrics.com/pages/contact_us";
NSString *const OCAppName                                   = @"Octopus Connector";

/* Device Names */

NSString *const OCDeviceNameAvatar                          = @"avatar";
NSString *const OCDeviceNameThinkgear                       = @"thinkgear";
NSString *const OCDeviceNameDemoDevice                      = @"mock_avatar";

/* User Defaults Keys */

NSString *const OCKeyRepo                                   = @"OCKeyRepo";
NSString *const OCKeyDevice                                 = @"OCKeyDevice";
NSString *const OCKeyPortAvatar                             = @"OCKeyPortAvatar";
NSString *const OCKeyPortThinkgear                          = @"OCKeyPortThinkgear";
NSString *const OCKeySelectedDeviceMenuIndex                = @"OCKeySelectedDeviceMenuIndex";
NSString *const OCKeySelectedDeviceTabIndex                 = @"OCKeySelectedDeviceTabIndex";

/* Notifications */

NSString *const OCConsoleOutputNotification                 = @"OCConsoleOutputNotification";
NSString *const OCPreferencesWillCloseNotification          = @"OCPreferencesWillCloseNotification";
NSString *const OCProcessExitedNotification                 = @"OCProcessExitedNotification";
