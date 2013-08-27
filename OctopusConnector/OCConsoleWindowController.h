//
//  OCConsoleWindowController.h
//  OctopusConnector
//
//  Created by Jake Brukhman on 8/26/13.
//  Copyright (c) 2013 East River Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OCConsoleWindowController : NSWindowController {
    __unsafe_unretained NSTextView *textView;
}

@property (unsafe_unretained) IBOutlet NSTextView *textView;

- (void)appendConsole:(NSString *)str;

@end
