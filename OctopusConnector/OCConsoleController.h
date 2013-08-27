//
//  OCConsoleController.h
//  OctopusStatusBar
//
//  Created by Jake Brukhman on 5/26/13.
//  Copyright (c) 2013 Octopus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OCConsoleController : NSWindowController {
    IBOutlet NSTextView *textView;
}

- (void)show;
- (void)hide;
- (BOOL)isVisible;
- (void)appendConsole:(NSString *)str;

@end


